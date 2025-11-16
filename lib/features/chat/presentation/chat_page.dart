import 'dart:io';

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
    setState(() {
      issue = Get.arguments;
    });
    if (issue != null) {
      issueController.setIssueUUID(issue!.uuid!);
      issueController.getChatForIssue(issue!.uuid!);
      issueController.startChatStream(issue!.uuid!);
    }
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isConnected = true;
    });
  }

  @override
  void dispose() {
    issueController.clearChat(); // cleanup when leaving page
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

        print('📁 Picked ${files.length} files:');
        for (final f in files) {
          print(' - ${f.path}');
        }

        // Pass a new list copy (prevents concurrent modification)
        issueController.selectFiles(List<File>.from(files));

        print('✅ Files selected successfully');
      } else {
        print('⚠️ No files selected.');
      }
    } catch (e) {
      print('❌ Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isConnected == false
            ? const Text('Loading...')
            : Text(issue!.patient!.fullName!),
      ),
      body: SafeArea(
        child: isConnected == false
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() {
                      if (issueController.chatLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final List<Message> messages =
                          issueController.chatMessages;

                      if (messages.isEmpty) {
                        return const Center(child: Text('No messages yet'));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final isMine = msg.from == 'doctor'; // or 'patient'

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
                    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10,right: 10),
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
