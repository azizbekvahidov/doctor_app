import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarWithStatus extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool isOnline;
  final bool showOnlineIndicator;
  final String? name;

  const AvatarWithStatus({
    super.key,
    this.imageUrl,
    this.size = 50,
    this.isOnline = false,
    this.showOnlineIndicator = false,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGray,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          if (showOnlineIndicator)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.24,
                height: size * 0.24,
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.onlineGreen : AppColors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primary.withOpacity(0.3),
      child: Center(
        child: name != null && name!.isNotEmpty
            ? Text(
                name![0].toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Icon(
                Icons.person,
                color: Colors.white,
                size: size * 0.5,
              ),
      ),
    );
  }
}
