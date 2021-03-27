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
      onHorizontalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 0) {
          onRightFling?.call();
        } else if ((details.primaryVelocity ?? 0) < 0) {
          onLeftFling?.call();
        }
      },
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 0) {
          onDownFling?.call();
        } else if ((details.primaryVelocity ?? 0) < 0) {
          onUpFling?.call();
        }
      },
    );
  }
}
