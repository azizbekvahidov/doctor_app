import 'package:country_flags/country_flags.dart';
import 'package:doctor_app/styles/app_colors.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LangButton extends StatelessWidget {
  final String lang;
  final Function() onTap;
  final Color? bgColor;
  final bool isSelected;

  const LangButton({
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
              child: AnimatedScale(
                scale: isSelected ? 1.1 : 1.0, // zoom effect on flag
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: CountryFlag.fromLanguageCode(
                  lang.toLowerCase(),
                  shape: Circle(),
                  height: isSelected ? 35 : 30,
                  width: isSelected ? 55 : 50,
                ),
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
