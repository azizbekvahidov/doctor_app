import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTextField extends StatelessWidget {
  MessageTextField({
    super.key,
    this.padding = EdgeInsets.zero,
    required this.controller,
    required this.onSend,
    required this.onSelectFile,
  });

  final EdgeInsets padding;
  final TextEditingController controller;
  final Function() onSend;
  final Function() onSelectFile;

  final IssueController issueController = Get.find<IssueController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding.add(const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final count = issueController.files.length;
              if (count == 0) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppBadge(
                    label: "$count file(s)",
                    tone: AppBadgeTone.soft,
                    icon: const Icon(Icons.attach_file_rounded),
                  ),
                ),
              );
            }),
            Row(
              children: [
                _IconButton(icon: Icons.attach_file_rounded, onTap: onSelectFile, kindGhost: true),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    style: AppText.body,
                    decoration: InputDecoration(
                      hintText: 'type message'.tr,
                      hintStyle: AppText.body.copyWith(color: AppColors.ink3),
                      filled: true,
                      fillColor: AppColors.surface2,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _IconButton(icon: Icons.send_rounded, onTap: onSend),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    this.kindGhost = false,
  });

  final IconData icon;
  final Function() onTap;
  final bool kindGhost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kindGhost ? AppColors.surface2 : AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: kindGhost ? AppColors.ink2 : Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
