import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          // File picker icon
          IconButton(
            icon: Icon(Icons.attach_file), // File attachment icon
            onPressed: onSelectFile,
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
