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
                return IconButton(
                  icon: Icon(
                    Icons.attach_file,
                    color: hasFiles
                        ? Colors.blue
                        : Colors.grey, // dynamic color
                  ),
                  onPressed: onSelectFile,
                );
              }),
            ],
          ),

          // TextField for typing message
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
          // Send button icon
          IconButton(
            icon: Icon(Icons.send), // Send message icon
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
