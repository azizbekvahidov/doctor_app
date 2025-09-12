import 'dart:io';

import 'package:doctor_app/features/shared/domain/models/response_data.dart';

abstract class CabinetRepository {
  Future<ResponseData> uploadDocument();
  Future<ResponseData> uploadAvatar(File avatarFile);
  Future<ResponseData> deleteDocument(int documentId);
  Future<void> createSchedule();
  Future<void> getSchedules();
}
