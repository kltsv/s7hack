import 'package:flutter/material.dart';

class FlingDetector extends StatelessWidget {
  static const _defaultSensitivity = 8;

  final int sensitivity;
  final Widget? child;

  final VoidCallback? onDownSwipe;
  final VoidCallback? onUpSwipe;
  final VoidCallback? onRightSwipe;
  final VoidCallback? onLeftSwipe;

  const FlingDetector({
    Key? key,
    this.child,
    this.onDownSwipe,
    this.onUpSwipe,
    this.onRightSwipe,
    this.onLeftSwipe,
    this.sensitivity = _defaultSensitivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onHorizontalDragUpdate: (details) {
      if (details.delta.dx > sensitivity) {
        onRightSwipe?.call();
      } else if (details.delta.dx < -sensitivity) {
        onLeftSwipe?.call();
      }
    }, onVerticalDragUpdate: (details) {
      if (details.delta.dy > sensitivity) {
        onDownSwipe?.call();
      } else if (details.delta.dy < -sensitivity) {
        onUpSwipe?.call();
      }
    });
  }
}
