import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/asset_finder.dart';
import '../../../core/widgets/circle.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_styles.dart';

class ActiveCard extends StatelessWidget {
  const ActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 175,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.pie_chart, size: 65),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Lorem ipsum dolor sit amet, consec tetur",
                        style: WorkSansStyle.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("Lorem Ipsum"),
              SizedBox(height: 2),
              Row(
                children: [Icon(LucideIcons.mapPin), Text("Lorem ipsum text")],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetFinder.icon('avatar'), height: 55),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Akhmadjon", style: WorkSansStyle.titleLarge),
              Text("Akbarov", style: WorkSansStyle.titleLarge),
            ],
          ),
          Spacer(),
          SizedBox(
            height: 65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Circle(
                  bgColor: AppColors.lightGray,
                  border: Border.all(color: Colors.transparent),
                  width: 50,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(AssetFinder.icon('notification')),
                  ),
                ),
                Positioned(
                  right: -2,
                  top: 0,
                  child: ShadBadge(
                    shape: CircleBorder(),
                    backgroundColor: AppColors.red,
                    child: Text('5', style: WorkSansStyle.labelLarge),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
