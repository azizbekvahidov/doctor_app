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
  });

  final TextEditingController? controller;
  final Widget? hintText;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextInputType? textInputType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      onChanged: onChanged,
      keyboardType: textInputType,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      enabled: enabled,
      controller: controller,
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
  const BasicTextFormField({
    super.key,
    required this.errorText,
    required this.controller,
    this.inputFormatters,
    this.hintText,
    this.initialValue,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicTextField(
            textInputType: textInputType,
            initialValue: initialValue,
            controller: controller,
            hintText: hintText,
            inputFormatters: inputFormatters,
          ),
          if (field.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                field.errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
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
