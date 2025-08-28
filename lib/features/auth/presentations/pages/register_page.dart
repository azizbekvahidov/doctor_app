import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/features/auth/domain/models/personal_data_form.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
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
                    await cleanControllers();
                  }
                },
                width: double.infinity,
                child: Obx(() {
                  if (authController.isAuthorization.value) {
                    return Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      ),
                    );
                  } else {
                    return Text(
                      page == 3 ? 'save'.tr : 'next'.tr,
                      style: WorkSansStyle.labelLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
