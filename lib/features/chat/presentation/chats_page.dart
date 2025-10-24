import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text("chats".tr),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: List.generate(5, (index) {
            return Card(
              child: ListTile(
                onTap: () {
                  // TODO: go to conversation page
                },
                leading: const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "A", // Initials or user avatar
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: const Text(
                  "Akhmadjon",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text(
                  "Hi",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "9:36 am",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
                    ),
                  ],
                ),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                // Adding shadow for depth
              ),
            );
          }),
        ),
      ),
    );
  }
}
