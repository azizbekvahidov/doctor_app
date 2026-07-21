import 'package:flutter/material.dart';

import '../config/app_environment.dart';
import '../services/alice_service.dart';

/// Draggable dev-only button that opens the Alice HTTP inspector.
///
/// Wraps the whole app via `GetMaterialApp.builder`, so it floats above every
/// screen. Renders nothing at all when [AppEnvironment.isDevelopment] is false,
/// so production builds are unaffected.
class DevToolsOverlay extends StatefulWidget {
  const DevToolsOverlay({super.key, required this.child});

  final Widget child;

  @override
  State<DevToolsOverlay> createState() => _DevToolsOverlayState();
}

class _DevToolsOverlayState extends State<DevToolsOverlay> {
  static const double _size = 52;
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    if (!AppEnvironment.isDevelopment) return widget.child;

    final Size screen = MediaQuery.sizeOf(context);
    final Offset pos =
        _position ?? Offset(screen.width - _size - 12, screen.height * 0.7);

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Positioned(
          left: pos.dx,
          top: pos.dy,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: AliceService.showInspector,
            onPanUpdate: (details) {
              setState(() {
                _position = Offset(
                  (pos.dx + details.delta.dx).clamp(0.0, screen.width - _size),
                  (pos.dy + details.delta.dy).clamp(0.0, screen.height - _size),
                );
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: _size,
                height: _size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xF0191A1E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bug_report_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
