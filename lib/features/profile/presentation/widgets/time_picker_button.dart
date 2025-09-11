import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class TimePickerButton extends StatelessWidget {
  final TimeOfDay? label;
  final ValueChanged<TimeOfDay> onPick;

  const TimePickerButton({
    super.key,
    required this.label,
    required this.onPick,
  });

  void _showCupertinoPicker(BuildContext context) {
    final initial = label ?? TimeOfDay.now();
    final initialDuration = Duration(
      hours: initial.hour,
      minutes: initial.minute,
    );

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        Duration selectedDuration = initialDuration;

        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("cancel".tr),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("select".tr),
                    onPressed: () {
                      final selectedTime = TimeOfDay(
                        hour: selectedDuration.inHours,
                        minute: selectedDuration.inMinutes % 60,
                      );
                      onPick(selectedTime);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  initialTimerDuration: initialDuration,
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (Duration newDuration) {
                    selectedDuration = newDuration;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.access_time, size: 18),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: Colors.black54),
      ),
      onPressed: () => _showCupertinoPicker(context),
      label: Text(
        label != null ? label!.format(context) : "00:00",
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
