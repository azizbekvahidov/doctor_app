import 'package:country_flags/country_flags.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LanguageSelectButton extends StatelessWidget {
  final String lang;
  final Function() onTap;
  final Color? bgColor;
  final bool isSelected;

  const LanguageSelectButton({
    super.key,
    required this.lang,
    required this.onTap,
    this.bgColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: isSelected ? 100 : 90,
            width: isSelected ? 100 : 90,
            decoration: BoxDecoration(
              color: bgColor ?? Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.lightGray,
                width: 3,
              ),
            ),
            child: Center(
              child: CountryFlag.fromLanguageCode(
                lang.toLowerCase(),
                shape: Circle(),
                height: 30,
                width: 50,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: WorkSansStyle.bodyLarge.copyWith(
            fontSize: isSelected ? 24 : 22,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.primary : Colors.black,
          ),
          child: Text(lang),
        ),
      ],
    );
  }
}
