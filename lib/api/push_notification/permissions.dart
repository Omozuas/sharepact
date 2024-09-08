import 'package:permission_handler/permission_handler.dart';

class PermissionsMethods {
  askNotificationPermission() async {
    Permission.notification.isDenied.then((v) {
      if (v) {
        Permission.notification.request();
      }
    });
  }
}
