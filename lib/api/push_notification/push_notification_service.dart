import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      "high_Importance_channel", "High Importance Notifications",
      description: "this channel is used for important notifications",
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<String?> generateDiviceToken() async {
    String? token = await firebaseMessaging.getToken();
    print({'devicetoken': token});
    return token;
  }

  Future initLocalNotification() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/launcher_icon');
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  listenToNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    //when app is terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      handleMessage(remoteMessage);
    });

    //forground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      handleMessage(remoteMessage);
      final notification = remoteMessage?.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/launcher_icon",
          ),
        ),
        payload: jsonEncode(remoteMessage?.toMap()),
      );
    });

    //baground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remotemessage) {
      handleMessage(remotemessage);
    });
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      print({'pay': message.data});
      message.data;
      print({'bb': message.toMap()});
      message.data;
    }
  }

  Future<void> handleBackgroundMessages(RemoteMessage message) async {
    print("Title: ${message.notification!.title}");
    print("Body: ${message.notification!.body}");
    print("Payload: ${message.data}");
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    // final fcmToken = await _firebaseMessaging.getToken();
    // print("Token:$fcmToken");

    await listenToNotification();
    await initLocalNotification();
  }
}
