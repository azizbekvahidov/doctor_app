import 'package:flutter/widgets.dart';

import '../../../core/design_system/styles/text_styles.dart';

class AnnouncementList extends StatelessWidget {
  const AnnouncementList({
    super.key,
    required this.title,
    this.height,
    this.child,
  });
  final String title;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: WorkSansStyle.titleLarge),
        SizedBox(height: 15),
        SizedBox(height: height, child: child),
      ],
    );
  }
}
