import 'package:flutter/material.dart';
import 'wd_onboarding_slide_item.dart';

class OnboardingCarouselWidget extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingSlideData> slides;
  final ValueChanged<int> onPageChanged;
  final int currentPage;

  const OnboardingCarouselWidget({
    super.key,
    required this.pageController,
    required this.slides,
    required this.onPageChanged,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7],
              ),
            ),
          ),
        ),

        PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) {
            final slide = slides[index];
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, child) {
                double pageOffset = 0.0;
                if (pageController.position.haveDimensions &&
                    pageController.page != null) {
                  pageOffset = pageController.page! - index;
                } else {
                  pageOffset = (currentPage - index).toDouble();
                }

                final double scale =
                    (1.0 - (pageOffset.abs() * 0.15)).clamp(0.85, 1.0);
                final double opacity =
                    (1.0 - (pageOffset.abs() * 0.65)).clamp(0.0, 1.0);

                return Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: child,
                  ),
                );
              },
              child: OnboardingSlideItem(slide: slide),
            );
          },
        ),
      ],
    );
  }
}
