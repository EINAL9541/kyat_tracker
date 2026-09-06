import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingBackgroundWidget extends StatelessWidget {
  final Widget child;

  const OnboardingBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.backgroundGradient,
            begin: Alignment(-0.8, -0.6),
            end: Alignment(0.8, 0.6),
          ),
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
