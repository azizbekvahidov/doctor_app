import 'package:flutter/material.dart';

class ValidatorWidget extends StatelessWidget {
  const ValidatorWidget({
    super.key,
    required this.errorText,
    required this.value,
    required this.child,
  });

  final Widget child;
  final String errorText;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,

          // 🔥 Animated error message
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1, // expand from top
                  child: child,
                ),
              );
            },
            child: field.errorText == null
                ? const SizedBox.shrink()
                : Padding(
                    key: ValueKey(field.errorText), // ensure animation triggers
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
          ),
        ],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
