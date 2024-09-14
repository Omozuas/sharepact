import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/push_notification/permissions.dart';
import 'package:sharepact_app/api/push_notification/push_notification_service.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/app_theme.dart';
import 'package:sharepact_app/screens/group_details/screen/chat.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/screens/notification/screen/notification_screen.dart';
import 'splash.dart';
import 'onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Make app always in portrait
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  PushNotificationService pushNotificationService = PushNotificationService();
  PermissionsMethods permissionsMethods = PermissionsMethods();
  await permissionsMethods.askNotificationPermission();
  pushNotificationService.initNotification();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SharePact',
      theme: AppTheme.theme, // Apply the custom theme
      home:
          const SplashScreenWithDelay(), // Use SplashScreenWithDelay as the home
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen(),
        ChatScreen.route: (context) => const ChatScreen()
      },
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
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3), () {}).then((_) {
      var token = preferences.getString('token');
      if (mounted) {
        if (token != null) {
          ref.watch(profileProvider).isTokenValid;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ControllerNavScreen()),
          );
        } else {
          ref.watch(profileProvider).isTokenValid;
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
    ref.watch(profileProvider).isTokenValid;
    return const SplashScreen();
  }
}
