import '../models/paginated_issues.dart';

abstract class IssueRepository {
  /// Fetch a paginated list of issues from the API
  Future<PaginatedIssues?> getIssues({int page = 1});
}
