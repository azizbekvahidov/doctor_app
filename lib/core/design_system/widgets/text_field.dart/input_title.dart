import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: WorkSansStyle.label.copyWith(color: AppColors.grey),
    );
  }
}
