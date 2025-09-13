import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/auth/domain/models/user.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/domain/repositories/cabinet_repository.dart';
import 'package:doctor_app/features/shared/domain/models/response_data.dart';

class CabinetRepositoryIml extends CabinetRepository {
  final Dio dio;
  CabinetRepositoryIml(this.dio);

  @override
  Future<ResponseData> uploadAvatar(File file) async {
    late ResponseData responseData;

    var formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(file.path),
      "_method": "patch",
    });

    try {
      final response = await dio.post(ApiConstants.avatar, data: formData);

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        LogHelper.info("✅ Upload successful: ${user.toJson()}");
        responseData = ResponseData(
          isSuccess: response.data['success'],
          user: user,
        );
      }
      return responseData;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<ResponseData> uploadDocument(documentFile) async {
    late ResponseData responseData;

    var formData = FormData.fromMap({
      "document": await MultipartFile.fromFile(documentFile.path),
      "_method": "put",
    });

    try {
      final response = await dio.post(ApiConstants.document, data: formData);

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        LogHelper.info("✅ Upload successful: ${user.toJson()}");
        responseData = ResponseData(
          isSuccess: response.data['success'],
          user: user,
        );
      } else {
        LogHelper.error(
          "❌ Upload failed: ${response.statusCode} - ${response.data}",
        );
      }
      return responseData;
    } on DioException catch (e) {
      LogHelper.error("❌ Dio error during upload: ${e.response!.data}");
      LogHelper.error("❌ Dio error during upload: ${e.response!.statusCode}");
      rethrow;
    }
  }

  @override
  Future<ResponseData> deleteDocument(documentId) async {
    try {
      Response response = await dio.delete(
        ApiConstants.document,
        data: {"document_id": documentId},
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        LogHelper.info("✅ Delete successful: ${user.toJson()}");
        return ResponseData(isSuccess: response.data['success'], user: user);
      }

      return ResponseData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createSchedule(scheduleData) async {
    try {
      Response response = await dio.post(
        ApiConstants.workSchedule,
        data: scheduleData,
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      LogHelper.error(
        "❌ Dio error during schedule creation: ${e.response!.data}",
      );
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Schedule>> getSchedules() async {
    try {
      Response response = await dio.get(ApiConstants.workSchedule);
      if (response.statusCode == 200) {
        List<Schedule> schedules = (response.data['data'] as List)
            .map((e) => Schedule.fromJson(e))
            .toList();
        return schedules;
      } else {
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createClinic() async {}
}
