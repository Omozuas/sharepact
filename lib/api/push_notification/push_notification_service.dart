import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> generateDiviceToken() async {
    String? token = await firebaseMessaging.getToken();
    print(token);
    return token;
  }

  listenToNotification() {
    //when app is terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        print(remoteMessage.data);
        remoteMessage.data;
      }
    });

    //forground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        print(remoteMessage.data);
        remoteMessage.data;
      }
    });

    //baground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remotemessage) {
      if (remotemessage != null) {
        print(remotemessage.data);
        remotemessage.data;
      }
    });
  }
}
