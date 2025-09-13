import 'package:doctor_app/core/wrappers/result.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';

abstract class CommonRepository {
  Future<List<String>> getSpecializations();
  Future<Result<List<Clinic>>> getClinics(String query);
  Future<List<String>> getDistricts();
  Future<Result<List<Region>>> getRegions();
}
