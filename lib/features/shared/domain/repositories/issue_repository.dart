import 'dart:io';

import 'package:doctor_app/features/chat/domain/models/message.dart';

import '../models/paginated_issues.dart';

abstract class IssueRepository {
  Future<PaginatedIssues?> getIssues({int page = 1});

  Future<List<Message>?> getIssueChat(String issueUuid, {int page = 1});

  Future<bool> archiveIssue(String issueUuid);

  Future<bool> sendMessage(String issueUuid, String message, {List<File>? files});


  Future<bool> readMessage(String issueUuid, int messageUuid);

  Future<bool> deleteMessage(String issueUuid, int messageUuid);
}
