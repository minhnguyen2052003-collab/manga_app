import 'package:flutter/foundation.dart';

import '../../../utils/Manga.dart';
enum MangaViewMode {
  home,
  searchText,
  category,
}
class ListMangaState {
  final String? title;
  final bool isLoading;
  final List<Manga> listManga;
  final MangaViewMode mode;
  final String? keyword;
  final String? slug;


  const ListMangaState({
    this.title,
    required this.isLoading,
    required this.listManga,
    required this.mode,
    this.slug,
    this.keyword
  });

  factory ListMangaState.initial() {
    return  const ListMangaState(
      isLoading: false,
      listManga: [],
      mode: MangaViewMode.home,
      title: "Danh sách truyện"
    );
  }

  ListMangaState copyWith({
    bool? isLoading,
    List<Manga>? listManga,
    MangaViewMode? mode,
    String? keyword,
    String? slug,
    String? title
  }) {
    return ListMangaState(
      isLoading: isLoading ?? this.isLoading,
      listManga: listManga ?? this.listManga,
      mode: mode ?? this.mode,
      keyword: keyword ?? this.keyword,
      slug: slug ?? this.slug,
      title: title?? this.title
    );
  }
}
