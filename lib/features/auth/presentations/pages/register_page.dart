import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/auth/domain/models/personal_data_form.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/auth/presentations/controller/register_screen_controller.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/personal_info_form.dart';
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
  // Controllers
  final RegisterScreenController registerScreenController =
      Get.find<RegisterScreenController>();
  final AuthController authController = Get.find<AuthController>();

  int page = 1;

  // form keys
  final personalFormKey = GlobalKey<FormState>();
  final educationFormKey = GlobalKey<FormState>();
  final socialFormKey = GlobalKey<FormState>();

  // TextEditingControllers
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

  PersonalFormData? personalFormData;

  cleanControllers() async {
    personalFormKey.currentState!.reset();
    socialFormKey.currentState!.reset();
    educationFormKey.currentState!.reset();
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    await registerScreenController.getUser();
    await Future.delayed(Durations.medium2);
    personalFormData = registerScreenController.personalFormData.value;
    if (personalFormData != null) {
      firstNameController.text = personalFormData!.firstName ?? "";
      lastNameController.text = personalFormData!.lastName ?? "";
      middleNameController.text = personalFormData!.middleName ?? "";
      birthdayController.text = personalFormData!.birthday ?? "";
      aboutRuController.text = personalFormData!.aboutRu ?? "";
      aboutUzController.text = personalFormData!.aboutUz ?? "";
      emailController.text = personalFormData!.email ?? "";
      phoneNumberController.text = personalFormData!.phoneNumber ?? "";
      experienceController.text = personalFormData!.experienceForm ?? "";
      instagramController.text = personalFormData!.instagramUsername ?? "";
      telegramController.text = personalFormData!.telegramUsername ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (page > 1) {
              setState(() => page--);
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          "personal information".tr,
          style: AppText.title.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Row(
                children: List.generate(3, (i) {
                  final done = i < page;
                  return Expanded(
                    child: Container(
                      height: 5,
                      margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                      decoration: BoxDecoration(
                        color: done ? AppColors.primary : AppColors.surface2,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
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
              child: Obx(
                () => AppButton(
                  block: true,
                  label: page == 3 ? 'save'.tr : 'next'.tr,
                  loading: authController.isAuthorization.value,
                  onPressed: () async {
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
                    personalFormData = registerScreenController
                        .personalFormData
                        .value!
                        .copyWith(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          middleName: middleNameController.text,
                          email: emailController.text,
                          birthday: birthdayController.text,
                          experienceForm: experienceController.text,
                          phoneNumber: phoneNumberController.text
                              .replaceAll("+", "")
                              .replaceAll(" ", '')
                              .replaceAll('-', ''),
                          degree: selectedDegreeController.text,
                          profession: selectedProfessionController.text,
                          aboutUz: aboutUzController.text,
                          aboutRu: aboutRuController.text,
                          telegramUsername: telegramController.text,
                          instagramUsername: instagramController.text,
                        );
                    registerScreenController.save(personalFormData!);
                    await authController.register();
                  }
                },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
