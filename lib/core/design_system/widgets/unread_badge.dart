import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';

class UnreadBadge extends StatelessWidget {
  final int? count;
  final double size;
  final Color color;
  final bool showZero;

  const UnreadBadge({
    super.key,
    this.count,
    this.size = 20,
    this.color = AppColors.accentPink,
    this.showZero = false,
  });

  @override
  Widget build(BuildContext context) {
    // Don't show if count is null or zero (unless showZero is true)
    if (count == null && !showZero) {
      return const SizedBox.shrink();
    }
    if (count == 0 && !showZero) {
      return const SizedBox.shrink();
    }

    final bool hasCount = count != null && count! > 0;
    final displayText = count != null && count! > 99 ? '99+' : count?.toString();

    return Container(
      constraints: BoxConstraints(
        minWidth: size,
        minHeight: size,
      ),
      padding: hasCount
          ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: hasCount
          ? Center(
              child: Text(
                displayText!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.55,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}

// Simple dot indicator for unread status
class UnreadDot extends StatelessWidget {
  final double size;
  final Color color;

  const UnreadDot({
    super.key,
    this.size = 10,
    this.color = AppColors.accentPink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
