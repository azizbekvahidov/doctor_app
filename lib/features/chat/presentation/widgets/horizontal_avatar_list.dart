import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/avatar_with_status.dart';
import 'package:flutter/material.dart';

class ContactItem {
  final String id;
  final String name;
  final String? imageUrl;
  final bool isOnline;

  ContactItem({
    required this.id,
    required this.name,
    this.imageUrl,
    this.isOnline = false,
  });
}

class HorizontalAvatarList extends StatelessWidget {
  final List<ContactItem> contacts;
  final ValueChanged<ContactItem>? onContactTap;

  const HorizontalAvatarList({
    super.key,
    required this.contacts,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return GestureDetector(
            onTap: () => onContactTap?.call(contact),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarWithStatus(
                    imageUrl: contact.imageUrl,
                    size: 55,
                    isOnline: contact.isOnline,
                    showOnlineIndicator: true,
                    name: contact.name,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatName(contact.name),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatName(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]}\n${parts[1]}';
    }
    return name;
  }
}
