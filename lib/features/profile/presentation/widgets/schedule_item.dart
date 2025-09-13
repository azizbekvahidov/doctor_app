import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({super.key, required this.schedule});
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: Text("place".tr, style: WorkSansStyle.titleMedium),
                ),
                SizedBox(height: 10),
                Text(
                  "${"clinic".tr}: ${schedule.clinic!.name!.ru}",
                  style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "${"address".tr}: ${schedule.clinic!.address!.ru}",
                  style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "${"main_price".tr}: ${PriceFormatter.format(double.parse(schedule.price!.main.toString()))}",
                  style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "${"second_price".tr}: ${PriceFormatter.format(double.parse(schedule.price!.second.toString()))}",
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
                    const SizedBox(height: 10),

                    // Table
                    Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide.none,
                        outside: BorderSide.none,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
                            SizedBox(height: 4),
                            SizedBox(),
                            SizedBox(),
                          ],
                        ),

                        ...schedule.schedule!.map((day) {
                          return TableRow(
                            children: [
                              Text(day.day!.tr, style: WorkSansStyle.bodyLarge),
                              Center(
                                child: Text(
                                  day.work!.from != null &&
                                          day.work!.until != null
                                      ? "${day.work!.from}  ${day.work!.until}"
                                      : "-",
                                  style: WorkSansStyle.bodyLarge,
                                ),
                              ),
                              Center(
                                child: Text(
                                  day.lunch!.from != null &&
                                          day.lunch!.until != null
                                      ? "${day.work!.from}  ${day.work!.until}"
                                      : "-",
                                  style: WorkSansStyle.bodyLarge,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
