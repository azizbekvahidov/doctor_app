import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../styles/dimens.dart';

/// v2 text field. Mirrors the design system's `VInput` but is fully functional
/// (wraps a real [TextField]).
class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.helper,
    this.keyboardType,
    this.obscureText = false,
    this.textarea = false,
    this.onChanged,
    this.inputFormatters,
    this.errorText,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? helper;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool textarea;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppText.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.ink2,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          minLines: textarea ? 3 : 1,
          maxLines: textarea ? 6 : 1,
          style: AppText.body.copyWith(fontWeight: FontWeight.w600),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.ink3,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : IconTheme(
                    data: const IconThemeData(color: AppColors.ink3, size: 20),
                    child: prefixIcon!,
                  ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: textarea ? 14 : 17,
            ),
            enabledBorder: _border(hasError ? AppColors.danger : AppColors.border),
            focusedBorder: _border(hasError ? AppColors.danger : AppColors.primary),
            border: _border(AppColors.border),
          ),
        ),
        if (helper != null || hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText ?? helper!,
            style: AppText.caption.copyWith(
              fontSize: 12,
              color: hasError ? AppColors.danger : AppColors.ink3,
            ),
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: AppRadii.inputR,
    borderSide: BorderSide(color: color, width: 1.5),
  );
}
