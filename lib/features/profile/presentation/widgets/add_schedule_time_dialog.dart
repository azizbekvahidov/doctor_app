import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/profile/utils/time_convertor.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'time_picker_button.dart';

class AddScheduleTimeDialog extends StatefulWidget {
  const AddScheduleTimeDialog({super.key, required this.cabinetController});
  final CabinetController cabinetController;

  @override
  State<AddScheduleTimeDialog> createState() => _AddScheduleTimeDialogState();
}

class _AddScheduleTimeDialogState extends State<AddScheduleTimeDialog> {
  final _formKey = GlobalKey<FormState>();

  String? selectedDay;

  TimeOfDay workStart = TimeOfDay(hour: 9, minute: 0);

  TimeOfDay workEnd = TimeOfDay(hour: 18, minute: 0);

  TimeOfDay lunchStart = TimeOfDay(hour: 13, minute: 0);

  TimeOfDay lunchEnd = TimeOfDay(hour: 14, minute: 0);

  final days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      widget.cabinetController.addSchedule(
        ScheduleElement(
          day: selectedDay,
          work: Lunch(from: workStart.to24hours(), until: workEnd.to24hours()),
          lunch: Lunch(
            from: lunchStart.to24hours(),
            until: lunchEnd.to24hours(),
          ),
        ),
      );
      Navigator.of(context).pop();
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
        child: SizedBox(
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
                initialValue: selectedDay,

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
                    child: TimePickerButton(
                      label: workStart,
                      onPick: (t) => setState(() => workStart = t),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TimePickerButton(
                      label: workEnd,
                      onPick: (t) => setState(() => workEnd = t),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text("lunch_time".tr, style: TextStyle(color: Colors.grey[700])),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TimePickerButton(
                      label: lunchStart,
                      onPick: (t) => setState(() => lunchStart = t),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TimePickerButton(
                      label: lunchEnd,
                      onPick: (t) => setState(() => lunchEnd = t),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              PrimaryButton(
                onTap: () => save(context),
                child: Text(
                  "add_day".tr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
