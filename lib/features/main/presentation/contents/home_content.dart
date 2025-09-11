import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/features/main/presentation/widgets/header.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../widgets/active_card.dart';
import '../widgets/announcement_list.dart';
import '../widgets/new_card.dart';

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
                  title: "new_ann".tr,
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
                  title: "active_ann".tr,
                  height: 175,
                  child: ListView.separated(
                    itemCount: 15,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => ActiveCard(
                      onClick: () {
                        Get.toNamed(Routes.detail);
                      },
                    ),
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
