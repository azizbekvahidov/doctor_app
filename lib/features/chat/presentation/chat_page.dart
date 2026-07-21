import 'dart:io';

import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/chat/domain/models/message.dart';
import 'package:doctor_app/features/chat/presentation/widgets/chat/message_bubble.dart';
import 'package:doctor_app/features/chat/presentation/widgets/chat/message_text_field.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isConnected = false;
  Issue? issue;

  final issueController = Get.find<IssueController>();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() => issue = Get.arguments);
    if (issue != null) {
      issueController.setIssueUUID(issue!.uuid!);
      issueController.getChatForIssue(issue!.uuid!);
      issueController.startChatStream(issue!.uuid!);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => isConnected = true);
  }

  @override
  void dispose() {
    issueController.clearChat();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (result != null && result.files.isNotEmpty) {
        final files = result.paths
            .whereType<String>()
            .map((path) => File(path))
            .toList();
        issueController.selectFiles(List<File>.from(files));
      }
    } catch (e) {
      LogHelper.error('File pick error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = issue?.patient?.fullName ?? '';
    final initials = name.isNotEmpty ? name[0].toUpperCase() : '';

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        titleSpacing: 0,
        title: isConnected == false
            ? Text('Loading...', style: AppText.body)
            : Row(
                children: [
                  AppAvatar(size: 38, initials: initials),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      name,
                      style: AppText.title.copyWith(fontSize: 17),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
      body: SafeArea(
        child: isConnected == false
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (issueController.chatLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final List<Message> messages =
                          issueController.chatMessages;
                      if (messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 40,
                                color: AppColors.ink3,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'No messages yet',
                                style: AppText.body.copyWith(
                                  color: AppColors.ink3,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isMine = msg.from == 'doctor';
                          return Align(
                            alignment: isMine
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: MessageBubble(
                              isRead: msg.readAt != null,
                              isMine: isMine,
                              message: msg,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  MessageTextField(
                    controller: _controller,
                    onSelectFile: _pickFiles,
                    onSend: () async {
                      final text = _controller.text.trim();
                      if (text.isEmpty && issueController.files.isEmpty) return;
                      await issueController.sendMessage(
                        text,
                        filesList: issueController.files,
                      );
                      _controller.clear();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
