import 'package:comic_app_gpt/presentation/list_manga_screen/modelview/manga_controller.dart';
import 'package:comic_app_gpt/domain/repository/manga_repository.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/modelview/manga_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../utils/Manga.dart';
import 'list_manga_state.dart';
import '../../../data/manga_api.dart';

class StateListMangaProvider extends StateNotifier<ListMangaState> {
  final MangaController controller;

  StateListMangaProvider(this.controller) : super(ListMangaState.initial());

  Future<void> loadHome() async {
    state = state.copyWith(
      isLoading: true,
      keyword: null,
      slug: null,
      mode: MangaViewMode.home,
      listManga: [],
      title: "Danh sách truyện"
    );
    final data = await controller.loadFirstPage();
    state = state.copyWith(isLoading: false, listManga: data);
  }

  Future<void> loadWithText(String keyword) async {
    state = state.copyWith(
      isLoading: true,
      listManga: [],
      keyword: keyword,
      slug: null,
      mode: MangaViewMode.searchText,
      title: "Kết quả tìm kiếm : $keyword"
    );
    final dataWithText = await controller.loadFirstPage(keyword: keyword);
    state = state.copyWith(isLoading: false, listManga: dataWithText);
  }

  Future<void> loadWithCategory(String slug) async {
    state = state.copyWith(
      isLoading: true,
      listManga: [],
      slug: slug,
      keyword: null,
      mode: MangaViewMode.category,
      title: "$slug"
    );
    final dataWithCate = await controller.loadFirstPage(slug: slug);
    state = state.copyWith(isLoading: false, listManga: dataWithCate);
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    List<Manga> listMore = [];
    switch (state.mode) {
      case MangaViewMode.searchText:
        listMore = await controller.loadNextPage(keyword: state.keyword);
        break;
      case MangaViewMode.category:
        listMore = await controller.loadNextPage(slug: state.slug);
        break;
      case MangaViewMode.home:
        listMore = await controller.loadNextPage();
        break;
    }

    state = state.copyWith(
      isLoading: false,
      listManga: [...state.listManga, ...listMore],
    );
  }
}

final stateListMangaProvider =
    StateNotifierProvider<StateListMangaProvider, ListMangaState>((ref) {
      final controller = ref.read(mangaControllerProvider);
      return StateListMangaProvider(controller);
    });
