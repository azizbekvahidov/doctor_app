import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
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
        Text(title.toUpperCase(), style: AppText.micro),
        const SizedBox(height: 8),
        Text(text, style: AppText.body.copyWith(color: AppColors.ink2)),
      ],
    );
  }
}
