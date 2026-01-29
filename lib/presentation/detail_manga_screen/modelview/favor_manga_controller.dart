import 'package:comic_app_gpt/domain/repository/manga_local_repository.dart';
import 'package:comic_app_gpt/domain/service/manga_local_data.dart';
import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class FavorMangaController {
  final MangaLocalRepository mangaLocalRepository;
  FavorMangaController(this.mangaLocalRepository);

  List<Manga> getFavorManga(){
    return mangaLocalRepository.getAllFavoriteManga();
  }
}

final favorMangaController =  Provider<FavorMangaController>((ref){
  final box = Hive.box<Manga>("mangaBox");
  return FavorMangaController(MangaLocalRepository(MangaLocalData(box)));
});