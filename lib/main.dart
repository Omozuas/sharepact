import 'package:flutter/material.dart';
import 'package:sharepact_app/app_theme.dart';
import 'splash.dart';
import 'onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharePact',
      theme: AppTheme.theme, // Apply the custom theme
      home:
          const SplashScreenWithDelay(), // Use SplashScreenWithDelay as the home
    );
  }
}

class SplashScreenWithDelay extends StatefulWidget {
  const SplashScreenWithDelay({super.key});

  @override
  SplashScreenWithDelayState createState() => SplashScreenWithDelayState();
}

class SplashScreenWithDelayState extends State<SplashScreenWithDelay> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3), () {}).then((_) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const OnboardingScreen()), // Navigate to OnboardingScreen
        );
      }
    }); // Set the delay here
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
