import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/shared/domain/models/paginated_issues.dart';

import '../../domain/repositories/issue_repository.dart';

class IssueRepositoryImpl extends IssueRepository {
  IssueRepositoryImpl({required this.dio});

  final Dio dio;

  @override
  Future<PaginatedIssues?> getIssues({int page = 1}) async {
    try {
      final response = await dio.get("${ApiConstants.issue}?page=$page");
      if (response.statusCode == 200) {
        final jsonData = response.data; // ✅ already decoded
        print(jsonData);
        print(response.data.runtimeType);

        return PaginatedIssues.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch issues: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data}');
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
