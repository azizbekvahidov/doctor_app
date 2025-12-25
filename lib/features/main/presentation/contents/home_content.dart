import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/app_search_bar.dart';
import 'package:doctor_app/core/design_system/widgets/consults_progress.dart';
import 'package:doctor_app/core/design_system/widgets/feature_card.dart';
import 'package:doctor_app/features/main/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../shared/controllers/issue_controller.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final issueController = Get.find<IssueController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Mock data for consults progress
    const int totalConsults = 9;
    const int completedConsults = 5;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await issueController.getInitialIssues();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            const SizedBox(height: 16),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppSearchBar(
                hintText: 'search_placeholder'.tr,
                isDarkBackground: isDark,
              ),
            ),
            const SizedBox(height: 24),

            // Consults for today section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'consults_for_today'.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.primary : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completedConsults ${'of'.tr} $totalConsults ${'completed'.tr}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const ConsultsProgress(
                    total: totalConsults,
                    completed: completedConsults,
                    size: 70,
                    strokeWidth: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Feature cards grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [
                  FeatureCard(
                    icon: LucideIcons.calendar,
                    title: 'schedule'.tr,
                    iconColor: AppColors.primary,
                    onTap: () {
                      // Navigate to schedule
                    },
                  ),
                  FeatureCard(
                    icon: LucideIcons.history,
                    title: 'consult_history'.tr,
                    iconColor: AppColors.primary,
                    onTap: () {
                      // Navigate to consult history
                    },
                  ),
                  FeatureCard(
                    icon: LucideIcons.users,
                    title: 'patient_management'.tr,
                    iconColor: AppColors.primary,
                    onTap: () {
                      // Navigate to patient management
                    },
                  ),
                  FeatureCard(
                    icon: LucideIcons.messageSquare,
                    title: 'free_consult'.tr,
                    subtitle: '150+ ${'news'.tr}',
                    iconColor: AppColors.primary,
                    onTap: () {
                      // Navigate to free consult
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
