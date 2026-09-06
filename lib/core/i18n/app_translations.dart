import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTranslations {
  const AppTranslations();

  String get back => "Back";
  String get next => "Next";
  String get done => "Done";

  String get appName => "Kyat Tracker";
  String get splashTagline => "Your personal finance manager";
  String get personalFinanceBadge => "PERSONAL FINANCE";

  String get skip => "Skip";
  String get getStarted => "Get Started";
  String get onboardingTitle1 => "Manage Your Finances";
  String get onboardingDesc1 => "Track your income, expenses, and savings with ease";
  String get onboardingTitle2 => "Track Your Budgets";
  String get onboardingDesc2 => "Set budgets and stay on top of your spending";
  String get onboardingTitle3 => "Achieve Your Goals";
  String get onboardingDesc3 => "Set savings goals and watch your progress";

  String get loginTitle => "Welcome Back";
  String get loginSubtitle => "Log in to continue managing your finances";
  String get useBiometric => "Use Biometric";
  String get enterPin => "Enter your PIN";
  String get forgotPin => "Forgot PIN?";
  String get loginSuccess => "Successfully logged in";
  String get or => "or";
}

final translationsProvider = Provider<AppTranslations>((ref) {
  return const AppTranslations();
});
