import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/design_system/styles/app_colors.dart';

class NewCard extends StatelessWidget {
  const NewCard({super.key, required this.onClick, required this.issue});

  final Issue issue;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(14),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      LucideIcons.stethoscope,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      issue.issue ?? "Medical Consultation",
                      style: WorkSansStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Patient name and birthdate
              if (issue.patient?.fullName != null)
                Row(
                  children: [
                    Icon(
                      LucideIcons.user,
                      color: AppColors.bottomItemColor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      issue.patient!.fullName!,
                      style: WorkSansStyle.labelLarge.copyWith(
                        color: AppColors.subTitleDark,
                      ),
                    ),
                  ],
                ),
              if (issue.patient?.fullName != null) const SizedBox(height: 6),

              // Address
              Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    color: AppColors.bottomItemColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      issue.address ?? "No address provided",
                      style: WorkSansStyle.labelLarge.copyWith(
                        color: AppColors.subTitleDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Birthdate (optional)
              if (issue.birthdate != null)
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      color: AppColors.bottomItemColor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${issue.birthdate!.year}-${issue.birthdate!.month.toString().padLeft(2, '0')}-${issue.birthdate!.day.toString().padLeft(2, '0')}",
                      style: WorkSansStyle.labelLarge.copyWith(
                        color: AppColors.subTitleDark,
                      ),
                    ),
                  ],
                ),

              // Inactive badge
              if (issue.inactiveAt != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Inactive",
                    style: WorkSansStyle.labelLarge.copyWith(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
