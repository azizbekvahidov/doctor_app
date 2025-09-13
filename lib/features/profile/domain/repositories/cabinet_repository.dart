import 'dart:io';

import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/shared/domain/models/response_data.dart';

abstract class CabinetRepository {
  Future<ResponseData> uploadDocument(File documentFile);
  Future<ResponseData> uploadAvatar(File avatarFile);
  Future<ResponseData> deleteDocument(int documentId);
  Future<bool> createSchedule(Map<String, dynamic> scheduleData);
  Future<List<Schedule>> getSchedules();
  Future<void> createClinic();
}
