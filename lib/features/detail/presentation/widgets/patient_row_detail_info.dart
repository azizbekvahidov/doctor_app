
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
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
      Text("$label:", style: WorkSansStyle.titleMedium),
      SizedBox(width: 10),
      Expanded(child: Text(value, style: WorkSansStyle.titleMedium)),
    ],
  );
}
