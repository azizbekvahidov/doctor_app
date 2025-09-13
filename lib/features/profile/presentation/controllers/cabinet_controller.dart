import 'dart:io';

import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/profile/data/repositories/cabinet_repository_iml.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/domain/repositories/cabinet_repository.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:doctor_app/features/shared/domain/models/response_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CabinetController extends GetxController {
  late CabinetRepository repository;
  RxString selectedAvatarPath = RxString('');
  RxBool isAvatarLoading = RxBool(false);
  RxBool isDocumentUploading = RxBool(false);
  RxBool isDeleting = RxBool(false);
  RxString selectedDocumentPath = RxString('');
  RxList<Schedule> schedules = RxList<Schedule>([]);

  final UserController userController = Get.find<UserController>();

  @override
  onInit() {
    super.onInit();
    repository = CabinetRepositoryIml(DioService().createDio());
    getSchedules();
  }

  uploadDocument() async {
    if (selectedDocumentPath.isEmpty) return;
    final file = File(selectedDocumentPath.value);

    try {
      isDocumentUploading.value = true;
      ResponseData responseData = await repository.uploadDocument(file);
      if (responseData.isSuccess) {
        userController.setUser(responseData.user!);
        selectedDocumentPath.value = '';
        Notifier.showSnackbar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: AppColors.success,
          content: Text("Document was uploaded successfully!"),
        );
      }
    } catch (e) {
      Notifier.showSnackbar(content: Text(e.toString()));
    } finally {
      isDocumentUploading.value = false;
    }
  }

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
      isDeleting.value = true;
      await Future.delayed(Duration(milliseconds: 800));
      ResponseData responseData = await repository.deleteDocument(documentId);
      if (responseData.isSuccess) {
        userController.setUser(responseData.user!);
        Notifier.showSnackbar(
          backgroundColor: AppColors.success,
          content: Text("Document was deleted successfully!"),
        );
      }
    } catch (e) {
      Notifier.showSnackbar(content: Text("Error: ${e.toString()}"));
    } finally {
      isDeleting.value = false;
    }
  }

  selectAvatarFile() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      selectedAvatarPath.value = pickedFile.path;
      await uploadAvatar();
    }
  }

  pickupDocuments() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        selectedDocumentPath.value = result.files.single.path!;
        await uploadDocument();
      }
    } catch (e) {
      LogHelper.error("❌ File picker error: $e");
    }
  }

  getSchedules() async {
    final fetchedSchedules = await repository.getSchedules();
    schedules.value = fetchedSchedules;
  }
}
