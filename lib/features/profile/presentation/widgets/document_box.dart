import 'package:flutter/material.dart';

class DocumentBox extends StatelessWidget {
  const DocumentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // allow overflow outside container
      children: [
        // Main container (image box)
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200], // light grey like in screenshot
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              size: 30,
              color: Colors.grey[500],
            ),
          ),
        ),

        // Close button on border
        Positioned(
          top: -12, // half outside
          right: -12, // half outside
          child: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.close, size: 18, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
