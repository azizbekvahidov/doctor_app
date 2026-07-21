import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../styles/dimens.dart';

/// v2 filter chip (`VChip`).
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.icon,
    this.onTap,
  });

  final String label;
  final bool selected;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : AppColors.surface,
          borderRadius: AppRadii.pillR,
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: selected ? Colors.white : AppColors.ink2,
                  size: 16,
                ),
                child: icon!,
              ),
              const SizedBox(width: 7),
            ],
            Text(
              label,
              style: AppText.caption.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : AppColors.ink2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSegmentedItem {
  const AppSegmentedItem({required this.key, required this.label, this.count});
  final String key;
  final String label;
  final int? count;
}

/// v2 segmented control (`VSegmented`).
class AppSegmented extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<AppSegmentedItem> items;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: AppRadii.pillR,
      ),
      child: Row(
        children: items.map((it) {
          final bool on = it.key == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(it.key),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: on ? AppColors.surface : Colors.transparent,
                  borderRadius: AppRadii.pillR,
                  boxShadow: on
                      ? const [
                          BoxShadow(
                            color: Color(0x14171A1F),
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      it.label,
                      style: AppText.caption.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: on ? AppColors.ink : AppColors.ink3,
                      ),
                    ),
                    if (it.count != null) ...[
                      const SizedBox(width: 5),
                      Text(
                        '${it.count}',
                        style: AppText.caption.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: on ? AppColors.primary : AppColors.ink3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// v2 star rating (`VStars`). Read-only when [onRate] is null, otherwise tappable.
class AppStars extends StatelessWidget {
  const AppStars({
    super.key,
    required this.value,
    this.size = 16,
    this.count,
    this.onRate,
  });

  final double value;
  final double size;
  final int? count;
  final ValueChanged<int>? onRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: onRate == null ? null : () => onRate!(i),
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Icon(
                Icons.star_rounded,
                size: size,
                color: i <= value.round()
                    ? AppColors.star
                    : const Color(0xFFE4E1DB),
              ),
            ),
          ),
        if (count != null) ...[
          const SizedBox(width: 2),
          Text(
            '$value · $count',
            style: AppText.caption.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.ink2,
            ),
          ),
        ],
      ],
    );
  }
}
