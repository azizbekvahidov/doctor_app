import 'dart:io';

import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/profile/data/repositories/cabinet_repository_iml.dart';
import 'package:doctor_app/features/profile/domain/repositories/cabinet_repository.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:doctor_app/features/shared/domain/models/response_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CabinetController extends GetxController {
  late CabinetRepository repository;
  RxString selectedAvatarPath = RxString('');
  RxBool isAvatarLoading = RxBool(false);

  final UserController userController = Get.find<UserController>();

  @override
  onInit() {
    super.onInit();
    repository = CabinetRepositoryIml(DioService().createDio());
  }

  uploadDocument() {}

  uploadAvatar() async {
    final file = File(selectedAvatarPath.value);
    isAvatarLoading.value = true;
    try {
      ResponseData responseData = await repository.uploadAvatar(file);
      if (responseData.isSuccess) {
        userController.setUser(responseData.user!);
        selectedAvatarPath.value = '';
        Notifier.showSnackbar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: AppColors.success,
          content: Text("Avatar was uploaded successfully!"),
        );
      }
    } catch (e) {
      Notifier.showSnackbar(content: Text(e.toString()));
    } finally {
      isAvatarLoading.value = false;
    }
  }

  deleteDocument(int documentId) async {
    try {
      ResponseData responseData = await repository.deleteDocument(documentId);
      if (responseData.isSuccess) {
        Notifier.showSnackbar(
          backgroundColor: Colors.lightGreen,
          content: Text("Document was deleted successfully!"),
        );
      }
    } catch (e) {
      Notifier.showSnackbar(content: Text(""));
    }
  }

  selectAvatarFile() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      selectedAvatarPath.value = pickedFile.path;
      print(pickedFile.path);
      await uploadAvatar();
    }
  }
}
