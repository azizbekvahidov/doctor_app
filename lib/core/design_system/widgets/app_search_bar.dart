import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool isDarkBackground;

  const AppSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.isDarkBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkBackground ? Colors.white : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkBackground
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText ?? 'Search...',
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            LucideIcons.search,
            color: AppColors.grey,
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
