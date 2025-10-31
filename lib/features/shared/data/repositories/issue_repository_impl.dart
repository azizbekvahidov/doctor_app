import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/chat/domain/models/message.dart';
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
        final jsonData = response.data;
        return PaginatedIssues.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch issues: ${response.statusCode}');
      }
    } on DioException catch (e) {
      LogHelper.error(e.toString());
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Message>?> getIssueChat(String issueUuid, {int page = 1}) async {
    try {
      final response = await dio.get("${ApiConstants.issue}/$issueUuid/chat");
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((e) => Message.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch chat: ${response.statusCode}');
      }
    } on DioException catch (e) {
      LogHelper.error(e.toString());
      return null;
    } catch (e) {
      LogHelper.error(e.toString());
      return null;
    }
  }

  @override
  Future<bool> sendMessage(String issueUuid, String message) async {
    final response = await dio.post(
      "${ApiConstants.issue}/$issueUuid",
      data: {"message": message},
    );
    return response.statusCode == 201;
  }

  @override
  Future<bool> deleteMessage(String issueUuid, int messageUuid) async {
    return false;
  }

  @override
  Future<bool> readMessage(String issueUuid, int messageUuid) async {
    final response = await dio.put(
      "${ApiConstants.issue}/$issueUuid/$messageUuid/read",
    );
    return response.statusCode == 200;
  }
}
