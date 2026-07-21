import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NewCard extends StatelessWidget {
  const NewCard({super.key, required this.onClick, required this.issue});

  final Issue issue;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onClick,
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  LucideIcons.stethoscope,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  issue.issue ?? "Medical Consultation",
                  style: AppText.headline,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (issue.patient?.fullName != null)
            _infoRow(LucideIcons.user, issue.patient!.fullName!),
          _infoRow(LucideIcons.mapPin, issue.address ?? "No address provided"),
          if (issue.birthdate != null)
            _infoRow(
              LucideIcons.calendar,
              "${issue.birthdate!.year}-${issue.birthdate!.month.toString().padLeft(2, '0')}-${issue.birthdate!.day.toString().padLeft(2, '0')}",
            ),
          if (issue.inactiveAt != null) ...[
            const SizedBox(height: 10),
            const AppBadge(label: "Inactive", tone: AppBadgeTone.danger),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.ink3, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppText.caption.copyWith(color: AppColors.ink2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
