import 'package:go_router/go_router.dart';
import '../../features/splash/sc_splash.dart';
import '../../features/onboarding/sc_onboarding.dart';
import '../../features/auth/sc_login.dart';
import '../../features/home/sc_home.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
