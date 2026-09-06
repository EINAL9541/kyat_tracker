import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/i18n/app_translations.dart';
import '_widget/wd_biometric_view.dart';
import '_widget/wd_login_background.dart';
import '_widget/wd_login_header.dart';
import '_widget/wd_pin_pad_view.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationsProvider);

    final showPin = useState(false);
    final pin = useState("");
    final success = useState(false);

    final biometricController = useAnimationController(
      duration: const Duration(milliseconds: 1800),
    );

    final logoController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      logoController.forward();
      biometricController.repeat();
      return null;
    }, []);

    void handleBiometric() {
      if (success.value) return;
      success.value = true;
      Timer(const Duration(milliseconds: 800), () {
        if (context.mounted) {
          try {
            context.go('/home');
          } catch (_) {}
        }
      });
    }

    void handleDigit(String digit) {
      if (pin.value.length < 4 && !success.value) {
        final nextPin = pin.value + digit;
        pin.value = nextPin;
        if (nextPin.length == 4) {
          success.value = true;
          Timer(const Duration(milliseconds: 600), () {
            if (context.mounted) {
              try {
                context.go('/home');
              } catch (_) {}
            }
          });
        }
      }
    }

    void handleDelete() {
      if (pin.value.isNotEmpty && !success.value) {
        pin.value = pin.value.substring(0, pin.value.length - 1);
      }
    }

    const numPadKeys = [
      "1", "2", "3",
      "4", "5", "6",
      "7", "8", "9",
      "", "0", "del",
    ];

    return LoginBackgroundWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginHeaderWidget(
            logoController: logoController,
            title: translations.loginTitle,
            subtitle: translations.loginSubtitle,
          ),
          const SizedBox(height: 40),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: const Cubic(0.22, 1, 0.36, 1),
            switchOutCurve: const Cubic(0.22, 1, 0.36, 1),
            transitionBuilder: (child, animation) {
              final slideAnim = Tween<Offset>(
                begin: const Offset(0, 0.12),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slideAnim,
                  child: child,
                ),
              );
            },
            child: !showPin.value
                ? BiometricViewWidget(
                    key: const ValueKey("biometric_mode"),
                    controller: biometricController,
                    isSuccess: success.value,
                    onTapBiometric: handleBiometric,
                    onEnterPin: () => showPin.value = true,
                    translations: translations,
                  )
                : PinPadViewWidget(
                    key: const ValueKey("pin_pad_mode"),
                    pin: pin.value,
                    isSuccess: success.value,
                    keys: numPadKeys,
                    onDigitTap: handleDigit,
                    onDeleteTap: handleDelete,
                    onBackTap: () {
                      pin.value = "";
                      success.value = false;
                      showPin.value = false;
                    },
                    translations: translations,
                  ),
          ),
        ],
      ),
    );
  }
}
