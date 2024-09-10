import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';

class UserProvider extends AutoDisposeAsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    getUserDetails();
    return null;
  }

  Future<void> getUserDetails() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getUser();
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final userProvider = AutoDisposeAsyncNotifierProvider<UserProvider, UserModel?>(
    UserProvider.new);
