import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import 'wd_loading_dots.dart';

class SplashMainContent extends HookWidget {
  const SplashMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final logoController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );

    final titleController = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    final taglineController = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    final badgeController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final dotsController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final logoScale = useAnimation(
      Tween<double>(begin: 0.35, end: 1.0).animate(
        CurvedAnimation(parent: logoController, curve: Curves.elasticOut),
      ),
    );
    final logoOpacity = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: logoController, curve: Curves.easeOut)),
    );

    final titleOffset = useAnimation(
      Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
        CurvedAnimation(
          parent: titleController,
          curve: const Cubic(0.22, 1, 0.36, 1),
        ),
      ),
    );
    final titleOpacity = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: titleController, curve: Curves.easeOut),
      ),
    );

    final taglineOpacity = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: taglineController, curve: Curves.easeOut),
      ),
    );

    final badgeScale = useAnimation(
      Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: badgeController, curve: Curves.easeOutBack),
      ),
    );
    final badgeOpacity = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: badgeController, curve: Curves.easeOut),
      ),
    );

    final dotsOpacity = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: dotsController, curve: Curves.easeOut)),
    );

    useEffect(() {
      final t1 = Timer(const Duration(milliseconds: 120), () {
        if (context.mounted) logoController.forward();
      });

      final t2 = Timer(const Duration(milliseconds: 550), () {
        if (context.mounted) titleController.forward();
      });

      final t3 = Timer(const Duration(milliseconds: 1000), () {
        if (context.mounted) taglineController.forward();
      });

      final t4 = Timer(const Duration(milliseconds: 1400), () {
        if (context.mounted) badgeController.forward();
      });

      final t5 = Timer(const Duration(milliseconds: 1700), () {
        if (context.mounted) dotsController.forward();
      });

      final navTimer = Timer(const Duration(milliseconds: 3200), () {
        if (context.mounted) {
          try {
            context.go('/onboarding');
          } catch (_) {}
        }
      });

      return () {
        t1.cancel();
        t2.cancel();
        t3.cancel();
        t4.cancel();
        t5.cancel();
        navTimer.cancel();
      };
    }, []);

    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: logoScale,
                  child: Opacity(
                    opacity: logoOpacity.clamp(0.0, 1.0),
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentBlue.withValues(alpha: 0.45),
                            blurRadius: 64,
                            offset: const Offset(0, 24),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/icon/app_logo.png',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                SlideTransition(
                  position: AlwaysStoppedAnimation(titleOffset),
                  child: Opacity(
                    opacity: titleOpacity.clamp(0.0, 1.0),
                    child: const Text(
                      'Kyat Tracker',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Opacity(
                  opacity: taglineOpacity.clamp(0.0, 1.0),
                  child: const Text(
                    'Your personal finance manager',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textLight,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Transform.scale(
                  scale: badgeScale,
                  child: Opacity(
                    opacity: badgeOpacity.clamp(0.0, 1.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      child: const Text(
                        'PERSONAL FINANCE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 56,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: dotsOpacity.clamp(0.0, 1.0),
              child: const LoadingDotsRow(),
            ),
          ),
        ),
      ],
    );
  }
}
