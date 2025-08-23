import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller,

      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: ShadDecoration(
        border: ShadBorder.all(
          color: Colors.grey, // default border color
        ),
        focusedBorder: ShadBorder.all(
          color: Colors.grey, // border when focused
          width: 2,
          radius: BorderRadius.circular(10),
        ),
        errorBorder: ShadBorder.all(
          color: Colors.red, // border when error
        ),
        disableSecondaryBorder: true,
      ),
    );
  }
}
