import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/notification-model/notification_moddel.dart';

class Notificationsprovider
    extends AutoDisposeAsyncNotifier<NotificationModdel?> {
  @override
  Future<NotificationModdel?> build() async {
    getNotifications(limit: 30);
    return null;
  }

  Future<void> getNotifications({required int limit}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getNotifications(limit: limit);
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final notificationsprovider = AutoDisposeAsyncNotifierProvider<
    Notificationsprovider, NotificationModdel?>(Notificationsprovider.new);
