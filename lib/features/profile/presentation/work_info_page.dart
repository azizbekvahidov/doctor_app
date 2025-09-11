import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WorkInfoPage extends StatelessWidget {
  const WorkInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "work_and_schedule".tr,
          style: WorkSansStyle.titleLarge.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Get.toNamed(Routes.createWorkSchedule),
        child: SvgPicture.asset(AssetFinder.icon('add_work')),
      ),
      body: Column(
        children: [
          Divider(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "place".tr,
                          style: WorkSansStyle.titleMedium,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${"clinic".tr}: Davlat Shifoxonasi",
                        style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${"address".tr}: Farg'ona, Kokand",
                        style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${"price".tr}: 2500\$",
                        style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Center(
                            child: Text(
                              "schedule".tr,
                              style: WorkSansStyle.titleMedium.copyWith(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Table
                          Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide.none,
                              outside: BorderSide.none,
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(2), // Дни wider
                              1: FlexColumnWidth(1.5), // Часы
                              2: FlexColumnWidth(1.5), // Обед
                            },
                            children: [
                              // Header row
                              TableRow(
                                children: [
                                  Text(
                                    "day".tr,
                                    style: WorkSansStyle.body.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "hour".tr,
                                      style: WorkSansStyle.body.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "lunch".tr,
                                      style: WorkSansStyle.body.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const TableRow(
                                children: [
                                  SizedBox(height: 8),
                                  SizedBox(),
                                  SizedBox(),
                                ],
                              ),

                              // Rows
                              TableRow(
                                children: [
                                  const Text("Понедельник:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Вторник:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Среда:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Четверг:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Пятница:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Суббота:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const Text("Воскресенье:"),
                                  Center(child: Text("9.30-17.15")),
                                  Center(child: Text("12.00-13.30")),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
