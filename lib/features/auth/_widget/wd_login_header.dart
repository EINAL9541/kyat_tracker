import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/app_colors.dart';

class LoginHeaderWidget extends StatelessWidget {
  final AnimationController logoController;
  final String title;
  final String subtitle;

  const LoginHeaderWidget({
    super.key,
    required this.logoController,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: CurvedAnimation(
            parent: logoController,
            curve: Curves.elasticOut,
          ),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: logoController,
              curve: Curves.easeOut,
            ),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlue.withValues(alpha: 0.42),
                    blurRadius: 48,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo/app_icon_transparent.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    AppColors.accentBlue,
                    BlendMode.srcIn,
                  ),
                  semanticsLabel: 'Kyat Tracker logo',
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: AppColors.textLight),
        ),
      ],
    );
  }
}
