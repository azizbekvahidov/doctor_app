import 'package:doctor_app/features/profile/presentation/widgets/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key, required this.schedules});

  final List<Schedule> schedules;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric().copyWith(
        top: 20,
        bottom: 5,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return ScheduleItem(schedule: schedule);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: schedules.length,
    );
  }
}
