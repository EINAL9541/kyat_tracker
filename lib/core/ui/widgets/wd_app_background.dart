import 'package:flutter/material.dart';
import 'package:kyat_tracker/core/theme/app_colors.dart';

class AppBackgroundWidget extends StatelessWidget {
  const new({super.key, required this.child});

  final Widget child;

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