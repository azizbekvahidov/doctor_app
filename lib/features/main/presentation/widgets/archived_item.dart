import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ArchivedItem extends StatelessWidget {
  const ArchivedItem({super.key, required this.archived});

  final Issue archived;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: 12,
      onTap: () => Get.toNamed(Routes.detail, arguments: archived),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.fileText,
              size: 20,
              color: AppColors.ink2,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              archived.issue ?? "No issue data",
              style: AppText.body.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.ink3),
        ],
      ),
    );
  }
}
