import 'dart:io';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
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

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.9;
  bool _downloading = false;

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
      setState(() => _downloading = true);
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final name =
            fileName ??
            url.split('/').last.split('?').first; // extract filename from URL
        final filePath = '${dir.path}/$name';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        await OpenFilex.open(file.path);
      } else {
        Get.snackbar('Error', 'Failed to download file.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Cannot open file: $e');
    } finally {
      if (mounted) setState(() => _downloading = false);
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAttachments = widget.message.attachments?.isNotEmpty ?? false;

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
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: widget.isMine ? Colors.blue[400] : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                  bottomLeft: Radius.circular(widget.isMine ? 16 : 0),
                  bottomRight: Radius.circular(widget.isMine ? 0.0 : 16),
                ),
              ),
              alignment: widget.isMine
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: widget.isMine
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
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: a.url!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (c, _) => Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.black12,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (c, _, __) => Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.isMine
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.insert_drive_file,
                                        size: 22,
                                        color: widget.isMine
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          a.fileName ?? 'Attachment',
                                          style: WorkSansStyle.label,
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
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.isMine ? Colors.white : Colors.black,
                      ),
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.message.createdAt != null
                            ? DateFormat(
                                "HH:mm",
                              ).format(widget.message.createdAt!)
                            : '',
                        style: TextStyle(
                          fontSize: 11,
                          color: widget.isMine
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                      if (widget.isMine)
                        Icon(
                          widget.isRead ? Icons.done_all : Icons.check,
                          size: 16,
                          color: widget.isRead ? Colors.white : Colors.white70,
                        ),
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
