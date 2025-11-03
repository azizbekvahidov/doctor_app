import 'package:doctor_app/features/main/presentation/contents/archive_content.dart';
import 'package:doctor_app/features/profile/presentation/profile_page.dart';

import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contents/main_content.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserController userController = Get.find();

  int index = 0;

  final List<Widget> pages = [
    MainContent(key: ValueKey("home")),
    ArchiveContent(key: ValueKey("archive")),
    ProfilePage(key: ValueKey("profile")),
  ];

  @override
  void initState() {
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            );
          },
          child: pages[index],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
