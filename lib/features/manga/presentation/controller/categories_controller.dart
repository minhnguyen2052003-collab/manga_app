import 'package:comic_app_gpt/features/auth/data/categories_repository.dart';
import 'package:comic_app_gpt/features/manga/data/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesController {
  final CategoriesRepository categoriesRepository;
  int limit = 20;
  int offset = 0;
  bool isLoading = false;
  bool hasMore = true;
  CategoriesController(this.categoriesRepository);

  Future<List<Category>> loadFirstPage() async {
    offset = 0;
    hasMore = true;
    final firstPage = await categoriesRepository.getCategoryPage(limit: limit,offset: offset);
    if(firstPage.length == limit){
      hasMore = true;
      offset = limit;
    }else if(firstPage.length < limit){
      hasMore = false;
    }
    return firstPage;

  }

  Future<List<Category>> loadNextPage() async {
    if(hasMore == false || isLoading ) return [];

    isLoading = true;

    final nextPage = await categoriesRepository.getCategoryPage(limit: limit , offset: offset);
    isLoading = false;

    if(nextPage.length < limit || nextPage.isEmpty){
      hasMore = false;
    }else if(nextPage.length == limit){
      hasMore = true;
    }

    offset += limit;
    return nextPage;

  }
}
final cateControllerProvider = Provider<CategoriesController>((ref){
  final repo = ref.read(categoriesRepoProvider);
  return CategoriesController(repo);
});