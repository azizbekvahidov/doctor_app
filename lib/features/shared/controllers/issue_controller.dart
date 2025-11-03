import 'dart:async';
import 'dart:io';

import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/shared/controllers/issue_event.dart';
import 'package:doctor_app/features/shared/data/repositories/issue_repository_impl.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:doctor_app/features/shared/domain/repositories/issue_repository.dart';
import 'package:get/get.dart';

import '../../chat/domain/models/message.dart';

class IssueController extends GetxController {
  final RxList<Issue> _allIssues = <Issue>[].obs;
  final RxList<Issue> issues = <Issue>[].obs; // active
  final RxList<Issue> archivedIssues = <Issue>[].obs;
  final RxList<File> files = <File>[].obs;

  var currentPage = 1;
  var lastPage = 1;
  var isLoading = false.obs;
  var isLoadingArchivedIssues = false.obs;
  var isMoreLoading = false.obs;
  final Rxn<IssueEvent> _uiEvent = Rxn<IssueEvent>();

  Rxn<IssueEvent> get uiEvent => _uiEvent;

  void sendEvent(IssueEvent event) {
    // always assign a NEW instance to trigger event
    _uiEvent.value = event;
  }

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
    initialize();
  }

  Future<void> initialize() async {
    await getInitialIssues();
    await getArchivedIssues();
  }

  Future<void> getInitialIssues() async {
    isLoading.value = true;
    try {
      final result = await repository.getIssues(page: 1);
      await Future.delayed(const Duration(milliseconds: 1000));

      if (result != null) {
        _allIssues.assignAll(result.data);
        issues.assignAll(activeIssues(result.data));
        archivedIssues.assignAll(archivedIssuesOnly(result.data));

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
      await Future.delayed(const Duration(milliseconds: 1000));

      if (result != null) {
        _allIssues.addAll(result.data);
        issues.addAll(activeIssues(result.data));
        archivedIssues.addAll(archivedIssuesOnly(result.data));

        currentPage = result.meta!.currentPage;
      }
    } finally {
      isMoreLoading.value = false;
    }
  }

  List<Issue> activeIssues(List<Issue> list) =>
      list.where((e) => e.inactiveAt == null).toList();

  List<Issue> archivedIssuesOnly(List<Issue> list) =>
      list.where((e) => e.inactiveAt != null).toList();

  Future<void> getArchivedIssues() async {
    isLoadingArchivedIssues.value = true;
    try {
      archivedIssues.assignAll(archivedIssuesOnly(_allIssues));
    } finally {
      isLoadingArchivedIssues.value = false;
    }
  }

  Future<void> archiveIssue() async {
    try {
      final isArchived = await repository.archiveIssue(activeIssueUuid.value!);
      if (isArchived) {
        sendEvent(Archive());
      }
    } catch (e) {
      LogHelper.error(e.toString());
    }
  }

  Future<void> getChatForIssue(String issueUuid) async {
    // chatLoading.value = true;
    activeIssueUuid.value = issueUuid;
    try {
      final messages = await repository.getIssueChat(issueUuid);

      if (messages != null) {
        chatMessages.assignAll(messages);
        markMessagesAsRead(messages, issueUuid);
      } else {
        chatMessages.clear();
      }
    } finally {
      // chatLoading.value = false;
    }
  }

  void markMessagesAsRead(List<Message> messages, issueUuid) async {
    for (var message in messages) {
      if (message.from == 'patient' && message.readAt == null) {
        await repository.readMessage(issueUuid, message.id!);
      }
    }
  }

  void startChatStream(String issueUUID) {
    _chatTimer?.cancel();
    _chatTimer = Timer.periodic(const Duration(milliseconds: 800), (_) async {
      await getChatForIssue(issueUUID);
    });
  }

  Future<void> sendMessage(String message, {List<File>? filesList}) async {
    if (activeIssueUuid.value == null) return;

    bool isSent = await repository.sendMessage(
      activeIssueUuid.value!,
      message,
      files: filesList,
    );

    if (isSent) {
      await getChatForIssue(activeIssueUuid.value!);
    }
  }

  void setIssueUUID(String uuid) {
    activeIssueUuid.value = uuid;
  }

  void selectFiles(List<File> filesList) {
    files.value = filesList;
  }

  void clearChat() {
    chatMessages.clear();
    _chatTimer?.cancel();
    activeIssueUuid.value = null;
    files.value = [];
  }

  @override
  void onClose() {
    clearChat();
    super.onClose();
  }
}
