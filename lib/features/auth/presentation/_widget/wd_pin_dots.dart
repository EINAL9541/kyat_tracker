import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PinDotsWidget extends StatelessWidget {
  final String pin;
  final bool isSuccess;

  const PinDotsWidget({
    super.key,
    required this.pin,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isFilled = index < pin.length;
          final isLatest = index == pin.length - 1 && !isSuccess;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: isLatest ? 18 : 16,
            height: isLatest ? 18 : 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled
                  ? (isSuccess ? AppColors.success : Colors.white)
                  : Colors.transparent,
              border: Border.all(
                color: isFilled
                    ? (isSuccess ? AppColors.success : Colors.white)
                    : Colors.white.withValues(alpha: 0.40),
                width: 2,
              ),
            ),
          );
        }),
      ),
    );
  }
}
