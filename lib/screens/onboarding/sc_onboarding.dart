import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyat_tracker/core/ui/widgets/wd_app_background.dart';
import '../../core/i18n/app_translations.dart';
import '_widget/wd_onboarding_carousel.dart';
import '_widget/wd_onboarding_cta_button.dart';
import '_widget/wd_onboarding_indicators.dart';
import '_widget/wd_onboarding_slide_item.dart';
import '_widget/wd_onboarding_top_bar.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationsProvider);
    final pageController = usePageController();
    final currentPage = useState(0);

    final slides = [
      OnboardingSlideData(
        icon: Icons.account_balance_wallet_rounded,
        title: translations.onboardingTitle1,
        description: translations.onboardingDesc1,
      ),
      OnboardingSlideData(
        icon: Icons.pie_chart_rounded,
        title: translations.onboardingTitle2,
        description: translations.onboardingDesc2,
      ),
      OnboardingSlideData(
        icon: Icons.track_changes_rounded,
        title: translations.onboardingTitle3,
        description: translations.onboardingDesc3,
      ),
    ];

    void navigateToLogin() {
      try {
        context.go('/login');
      } catch (_) {}
    }

    void handleNext() {
      if (currentPage.value < slides.length - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        navigateToLogin();
      }
    }

    final isLastSlide = currentPage.value == slides.length - 1;

    return AppBackgroundWidget(
      child: Column(
        children: [
          OnboardingTopBarWidget(
            showSkip: !isLastSlide,
            onSkip: navigateToLogin,
            skipLabel: translations.skip,
          ),
          Expanded(
            child: OnboardingCarouselWidget(
              pageController: pageController,
              slides: slides,
              currentPage: currentPage.value,
              onPageChanged: (page) => currentPage.value = page,
            ),
          ),
          OnboardingIndicatorsWidget(
            totalCount: slides.length,
            currentIndex: currentPage.value,
          ),
          OnboardingCtaButtonWidget(
            label: isLastSlide ? translations.getStarted : translations.next,
            isLastSlide: isLastSlide,
            onTap: handleNext,
          ),
        ],
      ),
    );
  }
}
