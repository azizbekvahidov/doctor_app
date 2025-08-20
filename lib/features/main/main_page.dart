import 'package:flutter/material.dart';

import 'widgets/active_card.dart';
import 'widgets/announcement_list.dart';
import 'widgets/new_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final List<Widget> pages = [
    const HomeContent(),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 15),
            child: Column(
              children: [
                AnnouncementList(
                  title: "New announcements",
                  height: 260,
                  child: ListView.separated(
                    itemCount: 15,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => const NewCard(),
                  ),
                ),
                const SizedBox(height: 30),
                AnnouncementList(
                  title: "Active announcements",
                  height: 175,
                  child: ListView.separated(
                    itemCount: 15,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => const ActiveCard(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
