import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/groupDetails/groupdetails.dart';

class Groupdetailsprovider
    extends AutoDisposeAsyncNotifier<GroupdetailsResponse?> {
  @override
  Future<GroupdetailsResponse?> build() async {
    return null;
  }

  Future<void> getGroupDetailsById({required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getGroupDetailsById(id: id);
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final groupdetailsprovider = AutoDisposeAsyncNotifierProvider<
    Groupdetailsprovider, GroupdetailsResponse?>(Groupdetailsprovider.new);
