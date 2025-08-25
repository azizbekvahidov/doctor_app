import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/features/auth/presentations/controller/register_screen_controller.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/personal_info_form.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/education_info_form.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/social_info_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterScreenController registerScreenController =
      Get.find<RegisterScreenController>();

  int page = 1; // start from 1
  final List<String> jobRoles = [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ];
  final personalFormKey = GlobalKey<FormState>();
  final educationFormKey = GlobalKey<FormState>();
  final socialFormKey = GlobalKey<FormState>();

  final TextEditingController aboutUzController = TextEditingController();
  final TextEditingController aboutRuController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController selectedDegreeController =
      TextEditingController();
  final TextEditingController selectedProfessionController =
      TextEditingController();

  late PersonalFormData personalFormData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            if (page > 1) {
              setState(() => page--);
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [Text("personal information".tr), Text("$page/3")],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  // Slide from right
                  final slide =
                      Tween<Offset>(
                        begin: const Offset(0.1, 0), // subtle slide
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      );

                  // Scale a little while sliding
                  final scale = Tween<double>(begin: 0.95, end: 1).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                  );

                  return SlideTransition(
                    position: slide,
                    child: FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: scale, child: child),
                    ),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey(page),
                  child: Builder(
                    builder: (context) {
                      if (page == 1) {
                        return PersonalInfoForm(
                          formKey: personalFormKey,
                          birthdayController: birthdayController,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          middleNameController: middleNameController,
                        );
                      } else if (page == 2) {
                        return EducationInfoForm(
                          jobRoles: jobRoles,
                          formKey: educationFormKey,
                          emailController: emailController,
                          phoneNumberController: phoneNumberController,
                          selectedDegreeController: selectedDegreeController,
                          selectedProfessionController:
                              selectedProfessionController,
                        );
                      } else {
                        return SocialInfoForm(
                          formKey: socialFormKey,
                          aboutUzController: aboutUzController,
                          aboutRuController: aboutRuController,
                          telegramController: telegramController,
                          instagramController: instagramController,
                          experienceController: experienceController,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: PrimaryButton(
                onTap: () async {
                  if (page == 1) {
                    final isValid = personalFormKey.currentState!.validate();
                    if (!isValid) {
                      await Future.delayed(const Duration(seconds: 2));
                      personalFormKey.currentState!.reset();
                      return;
                    }
                  }
                  if (page == 2) {
                    final isValid = educationFormKey.currentState!.validate();
                    if (!isValid) {
                      await Future.delayed(const Duration(seconds: 2));
                      educationFormKey.currentState!.reset();
                      return;
                    }
                  }
                  if (page == 3) {
                    final isValid = socialFormKey.currentState!.validate();
                    if (!isValid) {
                      await Future.delayed(const Duration(seconds: 2));
                      socialFormKey.currentState!.reset();
                      return;
                    }
                  }
                  if (page < 3) {
                    setState(() => page++);
                  } else if (page == 3) {
                    personalFormData = PersonalFormData(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      middleName: middleNameController.text,
                      email: emailController.text,
                      birthday: birthdayController.text,
                      experience: registerScreenController.calculateExperience(
                        experienceController.text,
                      ),
                      phoneNumber: phoneNumberController.text,
                      degree: selectedDegreeController.text,
                      profession: selectedProfessionController.text,
                      aboutUz: aboutUzController.text,
                      aboutRu: aboutRuController.text,
                      telegramUsername: telegramController.text,
                      instagramUsername: instagramController.text,
                    );
                    registerScreenController.save(personalFormData);
                  }
                },
                width: double.infinity,
                child: Text(
                  page == 3 ? 'save'.tr : 'next'.tr,
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
