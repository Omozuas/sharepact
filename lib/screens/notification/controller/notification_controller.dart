


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/screens/notification/model/notification_model.dart';
import 'package:sharepact_app/utils/mock/mock_notifications.dart';

class NotificationController extends ChangeNotifier{

    List<NotificationModel> userNotifications = allNotifications;

    removeNotification(int index){
      userNotifications.removeAt(index);
      notifyListeners();
    }
  
}

final notificationProvider = ChangeNotifierProvider<NotificationController>((ref)=> NotificationController());