import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons/float_button.dart';
import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/profile/presentation/widgets/schedule_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WorkInfoPage extends StatelessWidget {
  WorkInfoPage({super.key});
  final CabinetController cabinetController = Get.find<CabinetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "work_and_schedule".tr,
          style: WorkSansStyle.titleLarge.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
        ),
      ),
      floatingActionButton: FloatButton(
        onClick: () => Get.toNamed(Routes.createWorkSchedule),
      ),
      body: Obx(() {
        if (cabinetController.schedules.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text("no_schedules".tr, style: WorkSansStyle.bodyLarge),
            ),
          );
        } else {
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final schedule = cabinetController.schedules[index];
                return ScheduleItem(schedule: schedule);
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: cabinetController.schedules.length,
            ),
          );
        }
      }),
    );
  }
}
