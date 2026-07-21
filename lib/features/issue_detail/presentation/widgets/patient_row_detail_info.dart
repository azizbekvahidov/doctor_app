import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:flutter/material.dart';

class PatientRowDetailInfo extends StatelessWidget {
  const PatientRowDetailInfo({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 110,
        child: Text(
          label,
          style: AppText.caption.copyWith(color: AppColors.ink3),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          value,
          style: AppText.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
