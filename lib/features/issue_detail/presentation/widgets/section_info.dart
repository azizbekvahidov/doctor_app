import 'package:flutter/cupertino.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SectionInfo extends StatelessWidget {
  final String title;
  final String text;

  const SectionInfo({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: WorkSansStyle.headline4),
        SizedBox(height: 5),
        Text(text, style: WorkSansStyle.titleSmall),
      ],
    );
  }
}
