import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '_widget/wd_main_content.dart';
import '_widget/wd_splash_background.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SplashBackgroundWidget(
      child: SplashMainContent(),
    );
  }
}
