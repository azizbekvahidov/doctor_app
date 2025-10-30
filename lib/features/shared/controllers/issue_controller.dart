import 'package:dio/dio.dart';
import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/shared/data/repositories/issue_repository_impl.dart';
import 'package:doctor_app/features/shared/domain/repositories/issue_repository.dart';
import 'package:get/get.dart';

import '../domain/models/issue.dart';
import 'package:get/get.dart';

class IssueController extends GetxController {
  var issues = <Issue>[].obs;
  var currentPage = 1;
  var lastPage = 1;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  late IssueRepository repository;

  @override
  void onInit() {
    super.onInit();
    repository = IssueRepositoryImpl(dio: DioService().createDio());
    getInitialIssues();
  }

  Future<void> getInitialIssues() async {
    isLoading.value = true;

    try {
      final result = await repository.getIssues(page: 1);
      await Future.delayed(Duration(milliseconds: 1000));
      if (result != null) {
        issues.assignAll(result.data);
        currentPage = result.meta!.currentPage;
        lastPage = result.meta!.lastPage;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNextPage() async {
    if (isMoreLoading.value || currentPage >= lastPage) return;
    isMoreLoading.value = true;
    try {
      final nextPage = currentPage + 1;
      final result = await repository.getIssues(page: nextPage);
      await Future.delayed(Duration(milliseconds: 1000));
      if (result != null) {
        issues.addAll(result.data);
        currentPage = result.meta!.currentPage;
      }
    } finally {
      isMoreLoading.value = false;
    }
  }
}
