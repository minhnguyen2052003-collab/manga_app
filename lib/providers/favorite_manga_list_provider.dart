import 'package:comic_app_gpt/models/manga.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavoriteMangaProvider extends StateNotifier<List<Manga>> {
  FavoriteMangaProvider() : super([]);

  List<Manga> addToList(Manga manga) {
    state = [...state, manga];
    return state;
  }

  List<Manga> removeFromList(Manga manga) {
    if (state.isEmpty) {
      return state;
    }
    final newList = [...state];
    newList.remove(manga);
    state = newList;

    return state;
  }
}

final favoriteMangaProvider =
    StateNotifierProvider<FavoriteMangaProvider, List<Manga>>(
      (ref) => FavoriteMangaProvider(),
    );
