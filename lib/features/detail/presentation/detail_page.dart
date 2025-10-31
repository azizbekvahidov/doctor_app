import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/detail/presentation/widgets/patient_row_detail_info.dart';
import 'package:doctor_app/features/detail/presentation/widgets/section_info.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Issue? issue;

  @override
  void initState() {
    super.initState();
    getIssue();
  }

  getIssue() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      issue = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text("${"card".tr} №23"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.chat, arguments: issue!.uuid);
        },
        backgroundColor: AppColors.primary,
        child: SvgPicture.asset(AssetFinder.icon('chat'), height: 30),
      ),
      body: SafeArea(
        child: issue == null
            ? Center(child: CircularProgressIndicator(color: Colors.black))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Text(
                    "patient_information".tr,
                    style: WorkSansStyle.headline4,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        PatientRowDetailInfo(
                          label: "first_name".tr,
                          value: "Akhmad",
                        ),
                        SizedBox(height: 10),
                        PatientRowDetailInfo(
                          label: "last_name".tr,
                          value: "Akhmad",
                        ),
                        SizedBox(height: 10),
                        PatientRowDetailInfo(
                          label: "middle_name".tr,
                          value: "Akhmad",
                        ),
                        SizedBox(height: 10),
                        PatientRowDetailInfo(
                          label: "birthday".tr,
                          value: DateFormatter.birthday(DateTime.now()),
                        ),
                        SizedBox(height: 10),
                        PatientRowDetailInfo(
                          label: "address".tr,
                          value: "г. Ташкент, Навоий кучаси",
                        ),
                        SizedBox(height: 10),
                        PatientRowDetailInfo(
                          label: "complaint".tr,
                          value:
                              "фываолдфыов афылваождф ыловадфыоваджфыо вждалофыжвало",
                        ),
                      ],
                    ),
                  ),
                  SectionInfo(
                    title: "analysis_data".tr,
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 180,
                    child: Center(
                      child: Text("Image", style: WorkSansStyle.headline2),
                    ),
                  ),

                  SectionInfo(
                    title: "diagnosis".tr,
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  ),
                ],
              ),
      ),
    );
  }
}
