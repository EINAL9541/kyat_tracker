import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingSlideData {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class OnboardingSlideItem extends StatelessWidget {
  final OnboardingSlideData slide;

  const OnboardingSlideItem({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue.withValues(alpha: 0.45),
                  blurRadius: 56,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                slide.icon,
                size: 56,
                color: AppColors.iconBlue,
              ),
            ),
          ),
          const SizedBox(height: 48),

          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 290),
            child: Text(
              slide.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
