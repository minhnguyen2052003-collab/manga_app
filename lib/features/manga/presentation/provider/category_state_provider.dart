import 'package:comic_app_gpt/features/manga/data/models/category.dart';
import 'package:comic_app_gpt/features/manga/presentation/controller/categories_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

class ListCategoryState {
  final bool isLoading;
  final List<Category> listCate;

  const ListCategoryState({
    required this.isLoading,
    required this.listCate,
  });

  factory ListCategoryState.initial() {
    return const ListCategoryState(
      isLoading: false,
      listCate: [],
    );
  }

  ListCategoryState copyWith({
    bool? isLoading,
    List<Category>? listCate,
  }) {
    return ListCategoryState(
      isLoading: isLoading ?? this.isLoading,
      listCate: listCate ?? this.listCate,
    );
  }
}

class CateProvider extends StateNotifier<ListCategoryState>{
  final CategoriesController controller;
  CateProvider(this.controller) : super(ListCategoryState.initial());

  Future<void> loadFirt() async {
    state = state.copyWith(isLoading: true);
    final listFirst = await controller.loadFirstPage();
    state = state.copyWith(isLoading: false, listCate: listFirst);

  }

  Future<void> loadNext()async {
    if(state.isLoading) return;
    state = state.copyWith(isLoading: true );

    final listNext = await controller.loadNextPage();
    state = state.copyWith(isLoading: false,listCate: [...state.listCate,...listNext]);
  }
}

final cateProvider = StateNotifierProvider<CateProvider,ListCategoryState>((ref){
  final controller = ref.read(cateControllerProvider);
  return CateProvider(controller);
});