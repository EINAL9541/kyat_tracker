import 'package:flutter/material.dart';
import '../../../../core/i18n/app_translations.dart';
import '../../../../core/theme/app_colors.dart';
import 'wd_keypad_button.dart';
import 'wd_pin_dots.dart';

class PinPadViewWidget extends StatelessWidget {
  final String pin;
  final bool isSuccess;
  final List<String> keys;
  final Function(String) onDigitTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onBackTap;
  final AppTranslations translations;

  const PinPadViewWidget({
    super.key,
    required this.pin,
    required this.isSuccess,
    required this.keys,
    required this.onDigitTap,
    required this.onDeleteTap,
    required this.onBackTap,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        children: [
          PinDotsWidget(
            pin: pin,
            isSuccess: isSuccess,
          ),
          const SizedBox(height: 36),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: keys.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (context, index) {
              final key = keys[index];
              if (key.isEmpty) {
                return const SizedBox.shrink();
              }

              if (key == "del") {
                return KeypadButtonWidget(
                  onTap: onDeleteTap,
                  scaleDownTo: 0.78,
                  backgroundColor: Colors.white.withValues(alpha: 0.10),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                );
              }

              return KeypadButtonWidget(
                onTap: () => onDigitTap(key),
                scaleDownTo: 0.84,
                backgroundColor: Colors.white.withValues(alpha: 0.15),
                child: Text(
                  key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          TextButton(
            onPressed: onBackTap,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              "← ${translations.back}",
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
