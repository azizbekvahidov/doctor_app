import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/auth/domain/models/user.dart';
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

    print("📂 File exists? ${await file.exists()}");
    print("📂 File path: ${file.path}");
    print("📂 FormData fields: ${formData.fields}");
    print("📂 FormData files: ${formData.files}");
    try {
      final response = await dio.post(ApiConstants.avatar, data: formData);

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['data']);
        LogHelper.info("✅ Upload successful: ${user.toJson()}");
        responseData = ResponseData(
          isSuccess: response.data['success'],
          user: user,
        );
      } else {
        print("❌ Upload failed: ${response.statusCode} - ${response.data}");
      }
      return responseData;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseData> uploadDocument() {
    // TODO: implement uploadDocument
    throw UnimplementedError();
  }

  @override
  Future<ResponseData> deleteDocument(documentId) async {
    try {
      Response response = await dio.delete(
        ApiConstants.document,
        data: {"document_id": documentId},
      );
      return ResponseData();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createSchedule() async {}

  @override
  Future<void> getSchedules() {
    // TODO: implement getSchedules
    throw UnimplementedError();
  }
}
