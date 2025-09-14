import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/validator_widget.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'time_picker_button.dart';

class AddScheduleTimeDialog extends StatelessWidget {
  AddScheduleTimeDialog({super.key, required this.cabinetController});
  final CabinetController cabinetController;
  final _formKey = GlobalKey<FormState>();

  String? selectedDay;
  TimeOfDay? workStart;
  TimeOfDay? workEnd;
  TimeOfDay? lunchStart;
  TimeOfDay? lunchEnd;

  final days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  save() async {
    if (_formKey.currentState!.validate()) {
      cabinetController.addSchedule(
        ScheduleElement(
          day: selectedDay,
          work: Lunch(
            from: workStart?.to24hours(),
            until: workEnd?.to24hours(),
          ),
          lunch: Lunch(
            from: lunchStart?.to24hours(),
            until: lunchEnd?.to24hours(),
          ),
        ),
      );
      Get.back();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      _formKey.currentState!.reset();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: Form(
        key: _formKey,
        child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  Center(
                    child: Text(
                      "add_schedule".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown
                  DropdownButtonFormField<String>(
                    validator: (value) {
                      if (selectedDay == null || selectedDay!.isEmpty) {
                        return "valid_day".tr;
                      }
                      return null;
                    },
                    value: selectedDay,
                    hint: Text("select_weekday".tr),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: days
                        .map(
                          (day) => DropdownMenuItem(
                            value: day,
                            child: Text(day.toLowerCase().tr),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => selectedDay = value),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "opening_hours".tr,
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ValidatorWidget(
                          errorText: "valid_work_start".tr,
                          value: workStart.toString(),
                          child: TimePickerButton(
                            label: workStart,
                            onPick: (t) => setState(() => workStart = t),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ValidatorWidget(
                          errorText: "valid_work_end".tr,
                          value: workEnd.toString(),
                          child: TimePickerButton(
                            label: workEnd,
                            onPick: (t) => setState(() => workEnd = t),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "lunch_time".tr,
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ValidatorWidget(
                          errorText: "valid_lunch_start".tr,
                          value: lunchStart.toString(),
                          child: TimePickerButton(
                            label: lunchStart,
                            onPick: (t) => setState(() => lunchStart = t),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ValidatorWidget(
                          errorText: "valid_lunch_end".tr,
                          value: lunchEnd.toString(),
                          child: TimePickerButton(
                            label: lunchEnd,
                            onPick: (t) => setState(() => lunchEnd = t),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  PrimaryButton(
                    onTap: save,
                    child: Text(
                      "add_day".tr,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

extension TimeOfDayX on TimeOfDay {
  String to24hours() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return "$hourStr:$minuteStr";
  }
}
