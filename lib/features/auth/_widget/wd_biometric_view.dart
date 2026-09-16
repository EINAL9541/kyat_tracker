import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kyat_tracker/core/utils/utils_ring.dart';

import '../../../core/i18n/app_translations.dart';
import '../../../core/theme/app_colors.dart';

class BiometricViewWidget extends HookWidget {
  final AnimationController controller;
  final bool isSuccess;
  final VoidCallback onTapBiometric;
  final VoidCallback onEnterPin;
  final AppTranslations translations;

  const BiometricViewWidget({
    super.key,
    required this.controller,
    required this.isSuccess,
    required this.onTapBiometric,
    required this.onEnterPin,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = useState(1.0);
    final pinButtonScale = useState(1.0);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!isSuccess)
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return Stack(
                        alignment: Alignment.center,
                        children: List.generate(2, (index) {
                          final ring = RingUtils.biometricRingState(
                            controller.value,
                            index,
                          );

                          return Container(
                            width: ring.size,
                            height: ring.size,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(
                                  alpha: ring.opacity,
                                ),
                                width: 1.5,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),

                GestureDetector(
                  onTapDown: (_) => buttonScale.value = 0.90,
                  onTapUp: (_) {
                    buttonScale.value = 1.0;
                    onTapBiometric();
                  },
                  onTapCancel: () => buttonScale.value = 1.0,
                  child: AnimatedScale(
                    scale: buttonScale.value,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentBlue.withValues(alpha: 0.3),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            Icons.fingerprint_rounded,
                            key: ValueKey(isSuccess),
                            size: 40,
                            color: isSuccess
                                ? AppColors.success
                                : AppColors.iconBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Text(
            translations.useBiometric,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  translations.or,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          GestureDetector(
            onTapDown: (_) => pinButtonScale.value = 0.96,
            onTapUp: (_) {
              pinButtonScale.value = 1.0;
              onEnterPin();
            },
            onTapCancel: () => pinButtonScale.value = 1.0,
            child: AnimatedScale(
              scale: pinButtonScale.value,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        translations.enterPin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
