import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/list_of_groups/list_of_groups.dart';

class GroupListprovider extends AutoDisposeAsyncNotifier<GroupResponseList?> {
  @override
  Future<GroupResponseList?> build() async {
    getGroupList(limit: 15);
    return null;
  }

  Future<void> getGroupList({int? limit}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response =
          await auth.getGroupList(page: '1', limit: limit.toString());

      state = AsyncData(response);
      print({'data': state});
    } catch (e) {
      print('$e');
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final groupListprovider =
    AutoDisposeAsyncNotifierProvider<GroupListprovider, GroupResponseList?>(
        GroupListprovider.new);
