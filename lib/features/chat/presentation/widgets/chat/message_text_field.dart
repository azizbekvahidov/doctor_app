import 'package:doctor_app/core/design_system/styles/app_colors.dart';
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
    return Padding(
      padding: padding,
      child: Row(
        children: [
          // File picker icon
          Stack(
            children: [
              Obx(() {
                final hasFiles = issueController.files.isNotEmpty;
                return MessageTextFieldFunctionIconItem(
                  onClick: onSelectFile,
                  icon: Icons.attach_file,
                );
              }),
            ],
          ),

          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'type message'.tr,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          MessageTextFieldFunctionIconItem(onClick: onSend, icon: Icons.send),
        ],
      ),
    );
  }
}

class MessageTextFieldFunctionIconItem extends StatelessWidget {
  const MessageTextFieldFunctionIconItem({
    super.key,
    required this.onClick,
    required this.icon,
  });

  final Function() onClick;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.sendIcon,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.white),
      ),
    );
  }
}
