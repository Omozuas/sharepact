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
  final _iosChannel = const DarwinNotificationCategory(
    'HIGH_IMPORTANCE',
    options: <DarwinNotificationCategoryOption>{
      DarwinNotificationCategoryOption.allowAnnouncement,
      DarwinNotificationCategoryOption.allowInCarPlay,
    },
  );

  Future<String?> generateDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    // ignore: avoid_print
    print({'device': token});
    return token;
  }

  void handleMessage(RemoteMessage? message) {
    log('handleMessage');
    log('data ${message?.data}');
    log('notifytit ${message?.notification?.title}');
    log('notifybodyt ${message?.notification?.body}');
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
    var iOS = DarwinInitializationSettings(
      notificationCategories: <DarwinNotificationCategory>[_iosChannel],
    );
    const android = AndroidInitializationSettings('@drawable/launcher_icon');
    var settings = InitializationSettings(
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
      // var data = jsonDecode(message.notification?.body ?? '{}');
      // final body = NotificationBody.fromJson(data);
      // final body2 = ChatNotification.fromJson(data);
      log('...main$notification');
      if (notification == null) return;
      // String title = body.name ?? "New Notification";
      // String bodyText = body.subject ?? "You have a message";
      // String title1 = body2.group?.groupName ?? "New Notification";
      // String formattedBodyText =
      //     "${body2.message?.sender?.username ?? 'Someone'} : ${body2.message?.content ?? 'You have a new message'}";
      // if (data['type'] == "notification") {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/launcher_icon',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.toMap()),
      );
      // } else if (data['type'] == "chat") {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/launcher_icon',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.toMap()),
      );
      // }
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
  // var data = jsonDecode(message.notification?.body ?? '{}');
  // final body = NotificationBody.fromJson(data);
  log('...backgroung$notification');
  // final body2 = ChatNotification.fromJson(data);
  if (notification == null) return;
  // String title = body.name ?? "New Notification";
  // String bodyText = body.subject ?? "You have a message";
  // String title1 = body2.group?.groupName ?? "New Notification";
  // String formattedBodyText =
  //     "${body2.message?.sender?.username ?? 'Someone'} : ${body2.message?.content ?? 'You have a new message'}";

  // if (data['type'] == "notification") {
  localNotifications.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
          androidChannel.id, androidChannel.name,
          channelDescription: androidChannel.description,
          icon: '@drawable/launcher_icon',
          playSound: true),
      iOS: const DarwinNotificationDetails(presentSound: true),
    ),
    payload: jsonEncode(message.toMap()),
  );
  // } else if (data['type'] == "chat") {
  localNotifications.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        playSound: true,
        androidChannel.id,
        androidChannel.name,
        channelDescription: androidChannel.description,
        icon: '@drawable/launcher_icon',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
      ),
    ),
    payload: jsonEncode(message.toMap()),
  );
  // }
}
