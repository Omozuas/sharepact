import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/bank/bank_model.dart';

class GetBankProvider extends AutoDisposeAsyncNotifier<BankResponseModel?> {
  @override
  Future<BankResponseModel?> build() async {
    getBankById();
    return null;
  }

  Future<void> getBankById() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getBankById();
      state = AsyncData(response);
      print({'data': response});
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final getBankProvider =
    AutoDisposeAsyncNotifierProvider<GetBankProvider, BankResponseModel?>(
        GetBankProvider.new);
