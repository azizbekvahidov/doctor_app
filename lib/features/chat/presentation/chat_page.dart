import 'package:doctor_app/features/chat/presentation/widgets/chat/message_bubble.dart';
import 'package:doctor_app/features/chat/presentation/widgets/chat/message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  List<String> messages = [
    "HI",
    "How are you?",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanks",
    "I am fine thanksI am fine thanksI am fine thanksI am fine thanks",
  ];

  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image or file
  Future<void> _pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Here, you can handle the picked file (e.g., upload or display the image)
      print('Picked file: ${pickedFile.path}');
      // You can display or send the picked file as needed
    } else {
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ListView(
                  children: List.generate(messages.length, (index) {
                    return Align(
                      alignment: index % 2 == 0
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: MessageBubble(
                        isMine: index % 2 == 0,
                        message: messages[index],
                      ),
                    );
                  }),
                ),
              ),
            ),
            MessageTextField(
              padding: EdgeInsets.only(top: 10),
              controller: _controller,
              onSend: () {},
              onSelectFile: _pickFile,
            ),
          ],
        ),
      ),
    );
  }
}
