import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveContent extends StatelessWidget {
  const ArchiveContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "archive".tr,
          style: WorkSansStyle.headline3.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.separated(
        itemCount: 25,
        itemBuilder: (context, index) => Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                children: [
                  Icon(Icons.pie_chart, size: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consec tetur",
                      style: WorkSansStyle.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}
