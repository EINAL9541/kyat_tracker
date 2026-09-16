import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kyat_tracker/core/utils/utils_ring.dart';
import 'package:kyat_tracker/core/ui/widgets/wd_app_background.dart';

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

    return AppBackgroundWidget(
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
                    final ring = RingUtils.splashRingState(
                      ringsController.value,
                      index,
                    );

                    return Container(
                      width: ring.size,
                      height: ring.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: ring.opacity),
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
    );
  }
}
