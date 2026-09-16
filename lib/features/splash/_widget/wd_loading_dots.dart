import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoadingDotsRow extends StatelessWidget {
  const LoadingDotsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) => _LoadingDot(index: index)),
    );
  }
}

class _LoadingDot extends HookWidget {
  final int index;

  const _LoadingDot({required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1300),
    );

    useEffect(() {
      final timer = Timer(Duration(milliseconds: index * 240), () {
        if (context.mounted) {
          controller.repeat();
        }
      });
      return () {
        timer.cancel();
      };
    }, []);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final val = controller.value;
        final sinVal = Curves.easeInOut.transform(
          val < 0.5 ? val * 2 : (1.0 - val) * 2,
        );
        final opacity = 0.2 + (0.8 * sinVal);
        final scale = 0.8 + (0.35 * sinVal);

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}