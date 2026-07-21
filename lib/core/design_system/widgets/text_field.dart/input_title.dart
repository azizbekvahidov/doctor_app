import 'package:flutter/material.dart';

import '../../styles/app_text.dart';
import '../../styles/app_colors.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppText.caption.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.ink2,
      ),
    );
  }
}
