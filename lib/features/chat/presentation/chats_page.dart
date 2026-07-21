import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        centerTitle: true,
        title: Text("chats".tr, style: AppText.title.copyWith(fontSize: 18)),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return AppCard(
              padding: 12,
              onTap: () {
                // TODO: open the conversation (Phase 1 — Reverb chat)
              },
              child: Row(
                children: [
                  const AppAvatar(size: 46, initials: "A"),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Akhmadjon",
                          style: AppText.body.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Hi",
                          style: AppText.caption.copyWith(
                            color: AppColors.ink3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "9:36",
                    style: AppText.caption.copyWith(color: AppColors.ink3),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
