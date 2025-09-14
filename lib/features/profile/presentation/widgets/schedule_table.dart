import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/design_system/styles/text_styles.dart';

class ScheduleTable extends StatelessWidget {
  const ScheduleTable({super.key, required this.cabinetController});
  final CabinetController cabinetController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Table(
        border: TableBorder.symmetric(
          inside: BorderSide.none,
          outside: BorderSide.none,
        ),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2.4),
          2: FlexColumnWidth(2.4),
        },
        children: [
          // Header row
          TableRow(
            children: [
              Text("day".tr, style: WorkSansStyle.body),
              Center(child: Text("hour".tr, style: WorkSansStyle.body)),
              Center(child: Text("lunch".tr, style: WorkSansStyle.body)),
            ],
          ),
          const TableRow(
            children: [SizedBox(height: 8), SizedBox(), SizedBox()],
          ),

          // Rows
          ...cabinetController.selectedSchedules.map((day) {
            return TableRow(
              children: [
                GestureDetector(
                  onTap: () {
                    cabinetController.removeSchedule(day);
                  },
                  child: Text(day.day!.toLowerCase().tr),
                ),
                Center(
                  child: Text(
                    day.work!.from != null && day.work!.until != null
                        ? "${day.work!.from}-${day.work!.until}"
                        : "-",
                    style: WorkSansStyle.bodySmall,
                  ),
                ),
                Center(
                  child: Text(
                    day.lunch!.from != null && day.lunch!.until != null
                        ? "${day.lunch!.from}-${day.lunch!.until}"
                        : "-",
                    style: WorkSansStyle.bodySmall,
                  ),
                ),
              ],
            );
          }),
        ],
      );
    });
  }
}
