import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/categories/categoryByid.dart';

class CategorybyidProvider
    extends AutoDisposeAsyncNotifier<CategorybyidResponsModel?> {
  @override
  Future<CategorybyidResponsModel?> build() async {
    return null;
  }

  Future<void> getCategoriesById({required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = const AsyncLoading();
      final response = await auth.getCategoriesById(id: id);
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final categorybyidProvider = AutoDisposeAsyncNotifierProvider<
    CategorybyidProvider, CategorybyidResponsModel?>(CategorybyidProvider.new);
