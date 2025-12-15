import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchivedItem extends StatelessWidget {
  const ArchivedItem({super.key, required this.archived});

  final Issue archived;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.detail, arguments: archived),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            children: [
              Icon(Icons.pie_chart, size: 40),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  archived.issue ?? "No issue data",
                  style: WorkSansStyle.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
