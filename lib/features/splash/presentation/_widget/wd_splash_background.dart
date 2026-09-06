import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/theme/app_colors.dart';

class SplashBackgroundWidget extends HookWidget {
  final Widget child;

  const SplashBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ringsController = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );

    useEffect(() {
      ringsController.repeat();
      return null;
    }, []);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundGradient,
            begin: Alignment(-0.8, -0.6),
            end: Alignment(0.8, 0.6),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF3B82F6).withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),

            Center(
              child: AnimatedBuilder(
                animation: ringsController,
                builder: (context, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: List.generate(3, (index) {
                      double progress = ringsController.value - (index * 0.25);
                      if (progress < 0.0) progress += 1.0;

                      final curvedProgress = Curves.easeOut.transform(progress);
                      final size = 120.0 + (curvedProgress * (140.0 + index * 60.0));
                      final opacity = (0.55 * (1.0 - curvedProgress)).clamp(0.0, 0.55);

                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: opacity),
                            width: 1.2,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}