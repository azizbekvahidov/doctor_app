import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/wrappers/result.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/shared/domain/repositories/common_repository.dart';

class CommonRepositoryIml extends CommonRepository {
  final Dio dio;
  CommonRepositoryIml(this.dio);

  @override
  Future<List<String>> getDistricts() {
    // TODO: implement getDistricts
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getSpecializations() {
    // TODO: implement getSpecializations
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Region>>> getRegions() async {
    try {
      final response = await dio.get(ApiConstants.region);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Region> regions = data
            .map((regionJson) => Region.fromJson(regionJson))
            .toList();

        return Success(regions);
      } else {
        return Error('Failed to load regions');
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<Clinic>>> getClinics(query) async {
    final param = {'q': query};
    try {
      final response = await dio.get(
        ApiConstants.clinic,
        queryParameters: param,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Clinic> clinics = data
            .map((clinicJson) => Clinic.fromJson(clinicJson))
            .toList();

        return Success(clinics);
      } else {
        return Error('Failed to load clinics');
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
