import 'package:flutter/material.dart';

class FlingDetector extends StatelessWidget {
  static const _defaultSensitivity = 8;

  final int sensitivity;
  final Widget? child;

  final VoidCallback? onDownFling;
  final VoidCallback? onUpFling;
  final VoidCallback? onRightFling;
  final VoidCallback? onLeftFling;

  const FlingDetector({
    Key? key,
    this.child,
    this.onDownFling,
    this.onUpFling,
    this.onRightFling,
    this.onLeftFling,
    this.sensitivity = _defaultSensitivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > sensitivity) {
          onRightFling?.call();
        } else if (details.delta.dx < -sensitivity) {
          onLeftFling?.call();
        }
      },
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > sensitivity) {
          onDownFling?.call();
        } else if (details.delta.dy < -sensitivity) {
          onUpFling?.call();
        }
      },
    );
  }
}
