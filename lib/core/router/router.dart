import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/sc_splash.dart';
import '../../features/onboarding/presentation/sc_onboarding.dart';
import '../../features/auth/presentation/sc_login.dart';
import '../../features/home/presentation/home_screen.dart';

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
