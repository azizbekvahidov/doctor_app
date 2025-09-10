import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateWorkSchedulePage extends StatelessWidget {
  CreateWorkSchedulePage({super.key});
  List<String> medicalProfessionsKeys = [
    "general_practitioner",
    "dentist",
    "surgeon",
    "therapist",
    "pediatrician",
    "cardiologist",
    "neurologist",
    "oncologist",
    "orthopedist",
    "gynecologist",
    "urologist",
    "dermatologist",
    "psychiatrist",
    "radiologist",
    "ophthalmologist",
    "anesthesiologist",
    "endocrinologist",
    "family_doctor",
  ];

  Future<void> showAddScheduleDialog(BuildContext context) async {
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

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: StatefulBuilder(
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
                        "Добавить график",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      hint: const Text("select day"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: days
                          .map(
                            (day) =>
                                DropdownMenuItem(value: day, child: Text(day)),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => selectedDay = value),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Время работы",
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _TimePickerButton(
                            label: workStart,
                            onPick: (t) => setState(() => workStart = t),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TimePickerButton(
                            label: workEnd,
                            onPick: (t) => setState(() => workEnd = t),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Время обеда",
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _TimePickerButton(
                            label: lunchStart,
                            onPick: (t) => setState(() => lunchStart = t),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TimePickerButton(
                            label: lunchEnd,
                            onPick: (t) => setState(() => lunchEnd = t),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Submit button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // TODO: Handle save logic
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Добавить день",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("add_work_place".tr),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTitle(text: "clinic".tr),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FormField(
                    initialValue: medicalProfessionsKeys[0],
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropdown<String>(
                            decoration: CustomDropdownDecoration(
                              closedBorder: Border.all(color: AppColors.grey),
                              expandedBorder: Border.all(color: AppColors.grey),
                            ),
                            hintText: 'select_profession'.tr,
                            initialItem: medicalProfessionsKeys[0].tr,
                            items: medicalProfessionsKeys
                                .map((key) => key.tr)
                                .toList(),

                            onChanged: (value) {},
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                field.errorText!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                    validator: (value) {
                      // if (widget.selectedProfessionController.text.isEmpty) {
                      //   return "valid_profession".tr;
                      // }
                      // return null;
                    },
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: SvgPicture.asset(
                    AssetFinder.icon('add_work'),
                    color: AppColors.primary,
                    width: 28,
                    height: 28,
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            InputTitle(text: "Цена первого приема".tr),
            const SizedBox(height: 8),
            BasicTextFormField(
              errorText: "Цена первого приема",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 20),
            InputTitle(text: "Цена последующих приемов".tr),
            const SizedBox(height: 8),
            BasicTextFormField(
              errorText: "Цена последующих приемов",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    Center(
                      child: Text(
                        "schedule".tr,
                        style: WorkSansStyle.titleMedium.copyWith(),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: SvgPicture.asset(
                        AssetFinder.icon('add_work'),
                        color: AppColors.primary,
                        width: 28,
                        height: 28,
                      ),
                      onTap: () {
                        showAddScheduleDialog(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

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
                  children: [
                    // Header row
                    TableRow(
                      children: [
                        Text("Дни", style: WorkSansStyle.body),
                        Center(child: Text("Часы", style: WorkSansStyle.body)),
                        Center(child: Text("Обед", style: WorkSansStyle.body)),
                      ],
                    ),

                    const TableRow(
                      children: [SizedBox(height: 8), SizedBox(), SizedBox()],
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
    );
  }
}

class _TimePickerButton extends StatelessWidget {
  final TimeOfDay? label;
  final ValueChanged<TimeOfDay> onPick;

  const _TimePickerButton({required this.label, required this.onPick, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.access_time, size: 18),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: Colors.black54),
      ),
      onPressed: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: label ?? TimeOfDay.now(),
        );
        if (picked != null) onPick(picked);
      },
      label: Text(
        label != null ? label!.format(context) : "00:00",
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
