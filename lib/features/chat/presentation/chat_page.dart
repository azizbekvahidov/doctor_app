import 'package:doctor_app/features/chat/domain/models/message.dart';
import 'package:doctor_app/features/chat/presentation/widgets/chat/message_bubble.dart';
import 'package:doctor_app/features/chat/presentation/widgets/chat/message_text_field.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isConnected = false;
  String? issueUUID;
  final issueController = Get.find<IssueController>();

  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      issueUUID = Get.arguments;
    });
    if (issueUUID != null) {
      issueController.setIssueUUID(issueUUID!);
      issueController.getChatForIssue(issueUUID!);
      issueController.startChatStream(issueUUID!);
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

  Future<void> _pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Picked file: ${pickedFile.path}');
      // TODO: upload file if your API supports attachments
    } else {
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
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
                              isMine: isMine,
                              message: msg.message ?? '',
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  MessageTextField(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    controller: _controller,
                    onSelectFile: _pickFile,
                    onSend: () async {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;

                      issueController.sendMessage(text);

                      _controller.clear();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
