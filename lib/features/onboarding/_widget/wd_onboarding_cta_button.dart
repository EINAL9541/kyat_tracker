import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingCtaButtonWidget extends HookWidget {
  final String label;
  final bool isLastSlide;
  final VoidCallback onTap;

  const OnboardingCtaButtonWidget({
    super.key,
    required this.label,
    required this.isLastSlide,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = useState(1.0);

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 44),
      child: GestureDetector(
        onTapDown: (_) => buttonScale.value = 0.96,
        onTapUp: (_) {
          buttonScale.value = 1.0;
          onTap();
        },
        onTapCancel: () => buttonScale.value = 1.0,
        child: AnimatedScale(
          scale: buttonScale.value,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue.withValues(alpha: 0.35),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isLastSlide) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF1D4ED8),
                      size: 20,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
