import 'package:flutter/material.dart';

extension TimeOfDayX on TimeOfDay {
  String to24hours() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return "$hourStr:$minuteStr";
  }
}
