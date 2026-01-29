import 'package:comic_app_gpt/data/categories_api.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/category.dart';

class CategoriesRepository {
  final CategoriesApi categoriesApi;
  CategoriesRepository(this.categoriesApi);

  Future<List<Category>> getCategoryPage({int offset = 0, int limit = 20}) async {
    return await categoriesApi.fetchCategories(offset: offset, limit: limit);
  }
}

final categoriesRepoProvider = Provider<CategoriesRepository>((ref){
  final cateApi = ref.read(categoriesApiProvider);
  return CategoriesRepository(cateApi);
});