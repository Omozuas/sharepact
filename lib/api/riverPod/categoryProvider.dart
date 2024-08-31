import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';

class CategoryProvider
    extends AutoDisposeAsyncNotifier<List<CategoriesModel>?> {
  @override
  Future<List<CategoriesModel>?> build() async {
    getListCategories();
    return null;
  }

  Future<void> getListCategories() async {
    final auth = ref.read(authServiceProvider);

    try {
      state = const AsyncLoading();
      final response = await auth.getListCategories();
      // print(response.toList());
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final categoryProvider =
    AutoDisposeAsyncNotifierProvider<CategoryProvider, List<CategoriesModel>?>(
        CategoryProvider.new);
