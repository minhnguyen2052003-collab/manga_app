import 'package:comic_app_gpt/models/manga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:comic_app_gpt/services/api_service.dart';

class SearchMangaState {
  final List<Manga> data;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;

  const SearchMangaState({
    this.data = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
  });
}


class SearchMangaNotifier
    extends StateNotifier<SearchMangaState> {

  SearchMangaNotifier() : super(const SearchMangaState());

  int _offset = 0;
  final int _limit = 20;
  String? _currentKeyword;

  Future<void> search(String keyword) async {
    _currentKeyword = keyword;
    _offset = 0;

    state = const SearchMangaState(isLoading: true);

    final result = await ApiService().fetchMangaList(
      text: keyword,
      limit: _limit,
      offset: _offset,
    );

    state = SearchMangaState(
      data: result,
      isLoading: false,
      hasMore: result.length == _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    _offset += _limit;
    state = SearchMangaState(
      data: state.data,
      isLoading: false,
      isLoadingMore: true,
      hasMore: true,
    );

    final result = await ApiService().fetchMangaList(
      text: _currentKeyword!,
      limit: _limit,
      offset: _offset,
    );

    state = SearchMangaState(
      data: [...state.data, ...result],
      isLoading: false,
      isLoadingMore: false,
      hasMore: result.length == _limit,
    );
  }
}

final searchMangaProvider =
StateNotifierProvider<SearchMangaNotifier, SearchMangaState>(
      (ref) => SearchMangaNotifier(),
);
