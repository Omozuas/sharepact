import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';

class SubscriptionProvider
    extends AutoDisposeAsyncNotifier<List<SubscriptionModel>?> {
  @override
  Future<List<SubscriptionModel>?> build() async {
    getListActiveSub();
    return state.value;
  }

  Future<void> getListActiveSub({int? limit}) async {
    final auth = ref.read(authServiceProvider);

    try {
      state = const AsyncLoading();
      final response =
          await auth.getListActiveSub(page: '1', limit: limit.toString());
      response.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      print(response.toList());
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final subscriptionProvider = AutoDisposeAsyncNotifierProvider<
    SubscriptionProvider, List<SubscriptionModel>?>(SubscriptionProvider.new);
