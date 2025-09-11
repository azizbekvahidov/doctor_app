import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/profile/presentation/widgets/document_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "documents".tr,
          style: WorkSansStyle.titleLarge.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Дипломы, сертификаты и т.д.",
                  style: WorkSansStyle.titleMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                DocumentBox(),
                SizedBox(height: 10),
                DocumentBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
