import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/app_theme.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'splash.dart';
import 'onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharePact',
      theme: AppTheme.theme, // Apply the custom theme
      home:
          const SplashScreenWithDelay(), // Use SplashScreenWithDelay as the home
    );
  }
}

class SplashScreenWithDelay extends ConsumerStatefulWidget {
  const SplashScreenWithDelay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SplashScreenWithDelayState();
}

class SplashScreenWithDelayState extends ConsumerState<SplashScreenWithDelay> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _navigateToOnboarding());
  }

  Future<void> _navigateToOnboarding() async {
    final bool isTokenValid =
        await ref.read(profileProvider.notifier).validateToken();

    await Future.delayed(const Duration(seconds: 3), () {}).then((_) {
      if (mounted) {
        if (isTokenValid == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ControllerNavScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        }
      }
    }); // Set the delay here
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
