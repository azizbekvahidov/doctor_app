import 'dart:async';

import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/features/shared/data/repositories/issue_repository_impl.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:doctor_app/features/shared/domain/repositories/issue_repository.dart';
import 'package:get/get.dart';

import '../../chat/domain/models/message.dart';

class IssueController extends GetxController {
  var issues = <Issue>[].obs;
  var currentPage = 1;
  var lastPage = 1;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  // === Chat related ===
  Timer? _chatTimer;
  var chatMessages = <Message>[].obs;
  var chatLoading = false.obs;
  RxnString activeIssueUuid = RxnString(null);

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

  Future<void> getChatForIssue(String issueUuid) async {
    // chatLoading.value = true;
    activeIssueUuid.value = issueUuid;
    try {
      final messages = await repository.getIssueChat(issueUuid);

      if (messages != null) {
        chatMessages.assignAll(messages);
      } else {
        chatMessages.clear();
      }
    } finally {
      // chatLoading.value = false;
    }
  }

  // Start polling (auto refresh every few seconds)
  void startChatStream(String issueUUID) {
    _chatTimer?.cancel();
    _chatTimer = Timer.periodic(const Duration(milliseconds: 800), (_) async {
      await getChatForIssue(issueUUID);
    });
  }

  sendMessage(String message) async {
    if (activeIssueUuid.value == null) return;
    bool isSend = await repository.sendMessage(activeIssueUuid.value!, message);
    if (isSend) {
      getChatForIssue(activeIssueUuid.value!);
    }
  }

  void setIssueUUID(String uuid) {
    activeIssueUuid.value = uuid;
  }

  void clearChat() {
    chatMessages.clear();
    _chatTimer?.cancel();
    activeIssueUuid.value = null;
  }

  @override
  void onClose() {
    clearChat();
    super.onClose();
  }
}
