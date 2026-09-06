import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color gradientStart = Color(0xFF0C1445);
  static const Color gradientMiddle = Color(0xFF1A2D7A);
  static const Color gradientEnd = Color(0xFF1D4ED8);

  static const List<Color> backgroundGradient = [
    gradientStart,
    gradientMiddle,
    gradientEnd,
  ];

  static const Color accentBlue = Color(0xFF1D4ED8);
  static const Color iconBlue = Color(0xFF2563EB);

  static const Color primaryWhite = Colors.white;
  static const Color cardShadow = Color(0x731D4ED8); 

  static const Color textLight = Color(0xFFBFDBFE);
  static const Color textMuted = Color(0xB2BFDBFE);
  static const Color textDim = Color(0x66FFFFFF);

  static const Color success = Color(0xFF4ADE80);
  static const Color deleteRed = Colors.redAccent;
}
