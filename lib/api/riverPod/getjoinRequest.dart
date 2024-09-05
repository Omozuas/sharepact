import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/groupDetails/joinRequest.dart';

class GroupJoinRequestprovider
    extends AutoDisposeAsyncNotifier<GroupJoinRequestResponse?> {
  @override
  Future<GroupJoinRequestResponse?> build() async {
    return null;
  }

  Future<void> getGroupJoinRequestById({required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getGroupJoinRequestById(id: id);
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final groupJoinRequestprovider = AutoDisposeAsyncNotifierProvider<
    GroupJoinRequestprovider,
    GroupJoinRequestResponse?>(GroupJoinRequestprovider.new);
