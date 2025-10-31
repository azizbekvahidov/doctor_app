import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NewCard extends StatelessWidget {
  const NewCard({super.key, required this.onClick, required this.issue});

  final Issue issue;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onClick,
        child: Container(
          padding: EdgeInsets.all(10),
          width: 300,
          height: double.infinity,

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
                            issue.issue ?? "",
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
                    children: [
                      Icon(LucideIcons.mapPin),
                      Text(issue.address ?? ""),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
