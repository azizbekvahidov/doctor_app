import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdfx/pdfx.dart';

class DocumentBox extends StatelessWidget {
  final String? url;
  final String? name;
  final Function()? onClick;

  const DocumentBox({
    super.key,
    required this.url,
    required this.name,
    required this.onClick,
  });

  Future<String> downloadPdf(String url) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${url.split('/').last}');

    // If already downloaded, reuse
    if (await file.exists()) return file.path;

    // Download
    await Dio().download(url, file.path);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    final fileName = name?.toLowerCase() ?? "";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Builder(
            builder: (context) {
              // ✅ Image preview
              if (fileName.endsWith('.jpg') ||
                  fileName.endsWith('.jpeg') ||
                  fileName.endsWith('.png')) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    url!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          "Error loading image",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    },
                  ),
                );
              }

              if (fileName.endsWith('.pdf')) {
                return FutureBuilder<String>(
                  future: downloadPdf(url!), // download remote PDF
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Failed: ${snapshot.error}"));
                    }

                    final filePath = snapshot.data!;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: PdfView(
                        controller: PdfController(
                          document: PdfDocument.openFile(
                            filePath,
                          ), // ✅ local file
                          initialPage: 1,
                        ),
                      ),
                    );
                  },
                );
              }

              // ❌ No preview available
              return const Center(
                child: Text(
                  "No Preview Available",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: SizedBox(
            width: 30,
            height: 30,

            child: Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                onTap: onClick,
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
