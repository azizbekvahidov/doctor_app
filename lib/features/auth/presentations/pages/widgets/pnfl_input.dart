import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PnflInput extends StatelessWidget {
  const PnflInput({
    super.key,
    required this.controller,
    required this.maskFormatter,
  });

  final AuthController controller;
  final MaskTextInputFormatter maskFormatter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasError = controller.isTextFieldEmpty.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInput(
            controller: controller.pinflController,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.number,
            decoration: ShadDecoration(
              border: ShadBorder.all(
                color: hasError ? Colors.red : AppColors.grey,
                // width: 1.5,
              ),
              disableSecondaryBorder: true,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return SizeTransition(sizeFactor: animation, child: child);
            },
            child: hasError
                ? Padding(
                    key: const ValueKey('errorText'),
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'please enter jshshr'.tr,
                      style: WorkSansStyle.label.copyWith(color: AppColors.red),
                    ),
                  )
                : const SizedBox(key: ValueKey('emptyBox')),
          ),
        ],
      );
    });
  }
}
