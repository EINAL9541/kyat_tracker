import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyat_tracker/main.dart';
import 'package:kyat_tracker/features/onboarding/presentation/sc_onboarding.dart';
import 'package:kyat_tracker/features/auth/presentation/sc_login.dart';

void main() {
  testWidgets('Full app boots to Splash screen with branding', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.reset());

    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Kyat Tracker'), findsOneWidget);
    expect(find.text('Your personal finance manager'), findsOneWidget);
    expect(find.text('PERSONAL FINANCE'), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('Onboarding screen displays content and handles slide navigation', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.reset());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Manage Your Finances'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Track Your Budgets'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Achieve Your Goals'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Skip'), findsNothing);
  });

  testWidgets('Login screen toggles between Biometric and PIN views with keypad', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.reset());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Use Biometric'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint_rounded), findsOneWidget);
    expect(find.text('Enter your PIN'), findsOneWidget);

    await tester.tap(find.text('Enter your PIN'));
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('1'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('← Back'), findsOneWidget);

    await tester.tap(find.text('1'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('2'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('← Back'));
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Use Biometric'), findsOneWidget);
  });
}
