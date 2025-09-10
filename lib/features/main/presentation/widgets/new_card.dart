import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/design_system/widgets/buttons.dart';
import '../../../core/design_system/styles/text_styles.dart';

class NewCard extends StatelessWidget {
  const NewCard({super.key});

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
            height: 175,
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
                Row(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        PrimaryButton(
                          onTap: () {},
                          bgColor: Colors.transparent,
                          child: Text(
                            "dismiss".tr,
                            style: WorkSansStyle.labelLarge.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        PrimaryButton(
                          onTap: () {},
                          width: 65,
                          child: Text(
                            "Ok",
                            style: WorkSansStyle.labelLarge.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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
