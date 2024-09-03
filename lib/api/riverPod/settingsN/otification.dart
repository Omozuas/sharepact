import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/notificationmodel.dart';

class NotificationConfigProvider
    extends AutoDisposeAsyncNotifier<NotificationConfigResponse?> {
  @override
  Future<NotificationConfigResponse?> build() async {
    getNotificationConfig();
    return null;
  }

  Future<void> getNotificationConfig() async {
    final auth = ref.read(authServiceProvider);

    try {
      state = const AsyncLoading();
      final response = await auth.getNotificationConfig();
      print({'data': response.data?.id});
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final notificationConfigProvider = AutoDisposeAsyncNotifierProvider<
    NotificationConfigProvider,
    NotificationConfigResponse?>(NotificationConfigProvider.new);
