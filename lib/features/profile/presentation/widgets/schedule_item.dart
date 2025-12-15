import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleItem extends StatelessWidget {
  ScheduleItem({super.key, required this.schedule});

  final OnboardController onboardController = Get.find<OnboardController>();

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            onboardController.selectedLang.value == 'ru'
                ? schedule.clinic?.name?.ru ?? '--'
                : schedule.clinic?.name?.uz ?? "--",
            style: WorkSansStyle.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          children: [
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => _InfoRow(
                      label: "clinic".tr,
                      value: onboardController.selectedLang.value == 'ru'
                          ? schedule.clinic?.name?.ru ?? '--'
                          : schedule.clinic?.name?.uz ?? "--",
                    ),
                  ),
                  Obx(
                    () => _InfoRow(
                      label: "address".tr,
                      value: onboardController.selectedLang.value == 'ru'
                          ? schedule.clinic?.address?.ru ?? '--'
                          : schedule.clinic?.address?.uz ?? "--",
                    ),
                  ),
                  _InfoRow(
                    label: "first_price".tr,
                    value: PriceFormatter.format(
                      double.tryParse(schedule.price?.main.toString() ?? '0') ??
                          0,
                    ),
                  ),
                  _InfoRow(
                    label: "second_price".tr,
                    value: PriceFormatter.format(
                      double.tryParse(
                            schedule.price?.second.toString() ?? '0',
                          ) ??
                          0,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Schedule Table
                  Center(
                    child: Text(
                      "schedule".tr,
                      style: WorkSansStyle.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ScheduleTable(schedule: schedule),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$label: $value",
        style: WorkSansStyle.titleMedium.copyWith(fontSize: 16),
      ),
    );
  }
}

class _ScheduleTable extends StatelessWidget {
  final Schedule schedule;

  const _ScheduleTable({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
        inside: BorderSide.none,
        outside: BorderSide.none,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header
        TableRow(
          children: [
            Text("day".tr, style: _headerStyle),
            Center(child: Text("hour".tr, style: _headerStyle)),
            Center(child: Text("lunch".tr, style: _headerStyle)),
          ],
        ),
        const TableRow(children: [SizedBox(height: 8), SizedBox(), SizedBox()]),

        // Rows
        ...?schedule.schedule?.map(
          (day) => TableRow(
            children: [
              Text(day.day?.tr ?? "-", style: WorkSansStyle.bodyLarge),
              Center(
                child: Text(
                  _formatRange(day.work?.from, day.work?.until),
                  style: WorkSansStyle.bodyLarge,
                ),
              ),
              Center(
                child: Text(
                  _formatRange(day.lunch?.from, day.lunch?.until),
                  style: WorkSansStyle.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle get _headerStyle =>
      WorkSansStyle.body.copyWith(fontWeight: FontWeight.w600);

  String _formatRange(String? from, String? until) {
    return (from != null && until != null) ? "$from - $until" : "-";
  }
}
