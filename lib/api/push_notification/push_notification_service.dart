import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  
  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel", 
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<String?> generateDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    return token;
  }

  Future<void> initLocalNotification() async {
    // iOS and Android settings
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/launcher_icon'); // For Android only

    const settings = InitializationSettings(android: android, iOS: iOS);

    // Initializing local notifications
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });

    // Setting up Android notification channel
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> listenToNotification() async {
    // Requesting permissions for iOS
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return; // No need to proceed if permissions are denied
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // App is terminated
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage) {
      handleMessage(remoteMessage);
    });

    // App in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      handleMessage(remoteMessage);
      final notification = remoteMessage?.notification;
      if (notification == null) return;

      // Showing local notification
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/launcher_icon", // Custom icon for Android
          ),
        ),
        payload: jsonEncode(remoteMessage?.toMap()),
      );
    });

    // App in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      handleMessage(remoteMessage);
    });
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      // Handle your data or actions based on the notification content
    }
  }

  Future<void> handleBackgroundMessages(RemoteMessage message) async {
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    await listenToNotification();
    await initLocalNotification();
  }
}
