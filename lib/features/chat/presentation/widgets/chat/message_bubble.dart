import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.isMine,
    required this.message,
    required this.isRead,
  });

  final bool isMine;
  final String message;
  final bool isRead;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.9;

  @override
  void initState() {
    super.initState();
    // Trigger animation when message widget is first built
    Future.delayed(const Duration(milliseconds: 30), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: IntrinsicWidth(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: widget.isMine ? Colors.blue[400] : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                  bottomLeft: Radius.circular(widget.isMine ? 16 : 0),
                  bottomRight: Radius.circular(widget.isMine ? 0.0 : 16),
                ),
              ),
              alignment: widget.isMine
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: widget.isMine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  if (widget.isMine) ...[
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.isRead
                              ? Icons.done_all
                              : Icons.check, // ✓✓ for read, ✓ for sent
                          size: 16,
                          color: widget.isRead
                              ? Colors.white
                              : Colors.white70,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

