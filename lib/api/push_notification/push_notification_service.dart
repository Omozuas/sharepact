import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sharepact_app/api/push_notification/chat_notification.dart';
import 'package:sharepact_app/api/push_notification/notification_body.dart';
import 'package:sharepact_app/firebase_options.dart';
import 'package:sharepact_app/main.dart';
import 'package:sharepact_app/screens/group_details/screen/chat.dart';
import 'package:sharepact_app/screens/notification/screen/notification_screen.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  Future<String?> generateDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    // ignore: avoid_print
    print({'device': token});
    return token;
  }

  void handleMessage(RemoteMessage? message) {
    log('handleMessage');
    if (message == null) return;

    var data = jsonDecode(message.notification?.body ?? '{}');

    final body2 = ChatNotification.fromJson(data);

    if (data['type'] == "notification") {
      navigatorKey.currentState
          ?.pushNamed(NotificationScreen.route, arguments: message);
    } else if (data['type'] == "chat") {
      navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (contex) => ChatScreen(roomId: body2.group?.id)));
    }
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

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      var data = jsonDecode(message.notification?.body ?? '{}');
      final body = NotificationBody.fromJson(data);
      final body2 = ChatNotification.fromJson(data);
      if (notification == null) return;
      if (data['type'] == "notification") {
        _localNotifications.show(
          notification.hashCode,
          body.name,
          body.subject,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/launcher_icon',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      } else if (data['type'] == "chat") {
        _localNotifications.show(
          notification.hashCode,
          body2.group?.groupName ?? '',
          '${body2.message?.sender?.username ?? ''} : ${body2.message?.content ?? ''}',
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/launcher_icon',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future<void> initNotification() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await firebaseMessaging.requestPermission();
    initPushNotification();
    initLocalNotification();
  }
}

Future<void> handleBackgroundMessages(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  const androidChannel = AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );
  final notification = message.notification;
  var data = jsonDecode(message.notification?.body ?? '{}');
  final body = NotificationBody.fromJson(data);
  final body2 = ChatNotification.fromJson(data);
  if (notification == null) return;
  if (data['type'] == "notification") {
    localNotifications.show(
      notification.hashCode,
      body.name,
      body.subject,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/launcher_icon',
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  } else if (data['type'] == "chat") {
    localNotifications.show(
      notification.hashCode,
      body2.group?.groupName ?? '',
      '${body2.message?.sender?.username ?? ''} : ${body2.message?.content ?? ''}',
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/launcher_icon',
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }
}
