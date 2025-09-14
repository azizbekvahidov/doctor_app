import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({
    super.key,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.inputFormatters,
    this.initialValue,
    this.textInputType,
    this.onChanged,
    this.trailing,
  });

  final TextEditingController? controller;
  final Widget? hintText;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      onChanged: onChanged,
      keyboardType: textInputType,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      enabled: enabled,
      controller: controller,
      trailing: trailing,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      placeholder: hintText,
      decoration: ShadDecoration(
        border: ShadBorder.all(
          color: Colors.grey, // default border color
          radius: BorderRadius.circular(10),
        ),
        focusedBorder: ShadBorder.all(
          color: Colors.grey, // border when focused
          width: 1,
          radius: BorderRadius.circular(10),
        ),
        errorBorder: ShadBorder.all(
          color: Colors.red,
          radius: BorderRadius.circular(10),
        ),
        disableSecondaryBorder: true,
      ),
    );
  }
}

class BasicTextFormField extends StatelessWidget {
  final String errorText;
  final TextEditingController controller;
  final Widget? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final Widget? trailing;

  const BasicTextFormField({
    super.key,
    required this.errorText,
    required this.controller,
    this.inputFormatters,
    this.hintText,
    this.initialValue,
    this.textInputType,
    this.onChanged,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicTextField(
            onChanged: onChanged,
            textInputType: textInputType,
            initialValue: initialValue,
            controller: controller,
            hintText: hintText,
            inputFormatters: inputFormatters,
            trailing: trailing,
          ),
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
                      style: WorkSansStyle.label.copyWith(color: AppColors.red),
                    ),
                  ),
          ),
        ],
      ),
      validator: (value) {
        if (controller.text.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
