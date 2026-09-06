import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KeypadButtonWidget extends HookWidget {
  final VoidCallback onTap;
  final double scaleDownTo;
  final Color backgroundColor;
  final Widget child;

  const KeypadButtonWidget({
    super.key,
    required this.onTap,
    required this.scaleDownTo,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scale = useState(1.0);

    return GestureDetector(
      onTapDown: (_) => scale.value = scaleDownTo,
      onTapUp: (_) {
        scale.value = 1.0;
        onTap();
      },
      onTapCancel: () => scale.value = 1.0,
      child: AnimatedScale(
        scale: scale.value,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
