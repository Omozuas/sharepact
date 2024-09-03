// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/bank/getBank_model.dart';

class GetAllBankProvider extends AutoDisposeAsyncNotifier<GetAllBanks?> {
  @override
  Future<GetAllBanks?> build() async {
    getAllBank();
    return null;
  }

  Future<void> getAllBank() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getAllBanks();
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final getAllBankProvider =
    AutoDisposeAsyncNotifierProvider<GetAllBankProvider, GetAllBanks?>(
        GetAllBankProvider.new);
