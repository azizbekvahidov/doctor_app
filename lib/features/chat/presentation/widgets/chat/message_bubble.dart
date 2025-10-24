import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.isMine, required this.message});

  final bool isMine;
  final String message;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300, // Set your max width here
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMine ? Colors.blue[400] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12.0),
              topRight: const Radius.circular(12.0),
              bottomLeft: Radius.circular(isMine ? 16 : 0),
              bottomRight: Radius.circular(isMine ? 0.0 : 16),
            ),
          ),
          alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(message, style: WorkSansStyle.bodyLarge),
        ),
      ),
    );
  }
}
