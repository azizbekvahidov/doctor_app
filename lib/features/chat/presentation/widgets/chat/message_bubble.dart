import 'dart:io';
import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/chat/domain/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.isMine,
    required this.message,
    required this.isRead,
  });

  final bool isMine;
  final Message message;
  final bool isRead;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _opacity = 0.0;
  double _scale = 0.9;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 30), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });
  }

  bool _isImage(String? url) {
    if (url == null) return false;
    final lower = url.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }

  Future<void> _onAttachmentTap(String url, [String? fileName]) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final name = fileName ?? url.split('/').last.split('?').first;
        final file = File('${dir.path}/$name');
        await file.writeAsBytes(response.bodyBytes);
        await OpenFilex.open(file.path);
      } else {
        Get.snackbar('Error', 'Failed to download file.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Cannot open file: $e');
    } finally {
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool mine = widget.isMine;
    final hasAttachments = widget.message.attachments?.isNotEmpty ?? false;
    final Color bubble = mine ? AppColors.primary : AppColors.surface2;
    final Color onBubble = mine ? Colors.white : AppColors.ink;
    final Color meta = mine
        ? Colors.white.withValues(alpha: 0.75)
        : AppColors.ink3;

    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: IntrinsicWidth(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bubble,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(mine ? 18 : 4),
                  bottomRight: Radius.circular(mine ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: mine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasAttachments) ...[
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.message.attachments!.map((a) {
                        final isImage = _isImage(a.url);
                        return GestureDetector(
                          onTap: () => _onAttachmentTap(a.url!, a.fileName),
                          child: isImage
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: a.url!,
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.cover,
                                    placeholder: (c, _) => Container(
                                      width: 140,
                                      height: 140,
                                      color: Colors.black12,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (c, _, __) => Container(
                                      width: 140,
                                      height: 140,
                                      color: AppColors.surface2,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: mine
                                        ? Colors.white.withValues(alpha: 0.2)
                                        : AppColors.surface,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.insert_drive_file_rounded,
                                        size: 22,
                                        color: onBubble,
                                      ),
                                      const SizedBox(width: 6),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          a.fileName ?? 'Attachment',
                                          style: AppText.caption.copyWith(
                                            color: onBubble,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if ((widget.message.message ?? '').isNotEmpty)
                    Text(
                      widget.message.message ?? '',
                      style: AppText.body.copyWith(color: onBubble),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.message.createdAt != null
                            ? DateFormat("HH:mm").format(widget.message.createdAt!)
                            : '',
                        style: AppText.caption.copyWith(fontSize: 11, color: meta),
                      ),
                      if (mine) ...[
                        const SizedBox(width: 4),
                        Icon(
                          widget.isRead ? Icons.done_all_rounded : Icons.check_rounded,
                          size: 15,
                          color: widget.isRead ? Colors.white : meta,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
