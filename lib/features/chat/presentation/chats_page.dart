import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/app_search_bar.dart';
import 'package:doctor_app/core/design_system/widgets/avatar_with_status.dart';
import 'package:doctor_app/core/design_system/widgets/unread_badge.dart';
import 'package:doctor_app/features/chat/presentation/widgets/horizontal_avatar_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  // Mock data for contacts
  List<ContactItem> get _mockContacts => [
        ContactItem(
          id: '1',
          name: 'Dr. Mattie Harper',
          imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
          isOnline: true,
        ),
        ContactItem(
          id: '2',
          name: 'Dr. Lina Thompson',
          imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
          isOnline: true,
        ),
        ContactItem(
          id: '3',
          name: 'Dr. Dylan Oliver',
          imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg',
          isOnline: true,
        ),
        ContactItem(
          id: '4',
          name: 'Dr. Agnes Kim',
          imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
          isOnline: false,
        ),
      ];

  // Mock data for chats
  List<_ChatItem> get _mockChats => [
        _ChatItem(
          id: '1',
          name: 'NYC Hospital',
          lastMessage: 'Let me check his medical...',
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
          isOnline: true,
          hasUnread: true,
        ),
        _ChatItem(
          id: '2',
          name: 'Dr. Margaret Wells',
          lastMessage: 'I sent your patient contact...',
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
          isOnline: true,
          hasUnread: true,
        ),
        _ChatItem(
          id: '3',
          name: 'Dr. Christine Bradley',
          lastMessage: 'How do you think?',
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
          isOnline: true,
          hasUnread: false,
        ),
        _ChatItem(
          id: '4',
          name: 'Dr. Dylan Oliver',
          lastMessage: 'Yes!',
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/men/46.jpg',
          isOnline: false,
          hasUnread: false,
        ),
        _ChatItem(
          id: '5',
          name: 'Dr. Marguerite Sutton',
          lastMessage: 'Ok. I got it. Thank you',
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
          isOnline: false,
          hasUnread: false,
        ),
        _ChatItem(
          id: '6',
          name: 'Dr. Lina Thompson',
          lastMessage: "That's good idea! I think so.",
          time: '1:50',
          imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
          isOnline: false,
          hasUnread: false,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppSearchBar(
                hintText: 'search'.tr,
                isDarkBackground: isDark,
              ),
            ),
            const SizedBox(height: 20),

            // Horizontal avatar list
            HorizontalAvatarList(
              contacts: _mockContacts,
              onContactTap: (contact) {
                // Navigate to chat
              },
            ),
            const SizedBox(height: 8),

            // Chat list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _mockChats.length,
                itemBuilder: (context, index) {
                  final chat = _mockChats[index];
                  return _buildChatItem(
                    context,
                    chat,
                    textColor,
                    subtitleColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context,
    _ChatItem chat,
    Color textColor,
    Color subtitleColor,
  ) {
    return InkWell(
      onTap: () {
        // Navigate to chat conversation
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Unread indicator
            SizedBox(
              width: 16,
              child: chat.hasUnread
                  ? const UnreadDot(size: 8)
                  : const SizedBox.shrink(),
            ),

            // Avatar with online status
            AvatarWithStatus(
              imageUrl: chat.imageUrl,
              size: 55,
              isOnline: chat.isOnline,
              showOnlineIndicator: true,
              name: chat.name,
            ),
            const SizedBox(width: 12),

            // Name and message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),

            // Time
            Text(
              chat.time,
              style: TextStyle(
                fontSize: 13,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String? imageUrl;
  final bool isOnline;
  final bool hasUnread;

  _ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.imageUrl,
    this.isOnline = false,
    this.hasUnread = false,
  });
}
