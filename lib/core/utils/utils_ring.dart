import 'package:flutter/material.dart';

class RingUtils {
  static RingState splashRingState(double value, int index) {
    double progress = value + (index * 0.5);
    if (progress > 1.0) progress -= 1.0;

    final curved = Curves.easeOut.transform(progress);
    final size = 140.0 + (curved * ((index + 1) * 60.0 + 60.0));
    final opacity = (0.5 * (1.0 - curved)).clamp(0.0, 0.5);

    return RingState(size: size, opacity: opacity);
  }

  static RingState biometricRingState(double value, int index) {
    double progress = value + (index * 0.5);
    if (progress > 1.0) progress -= 1.0;

    final curved = Curves.easeOut.transform(progress);
    final size = 80.0 + (curved * ((index + 1) * 36.0 + 36.0));
    final opacity = (0.4 * (1.0 - curved)).clamp(0.0, 0.4);

    return RingState(size: size, opacity: opacity);
  }
}

class RingState {
  final double size;
  final double opacity;

  RingState({required this.size, required this.opacity});
}
