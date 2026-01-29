import 'package:comic_app_gpt/domain/service/manga_local_data.dart';
import 'package:comic_app_gpt/utils/Manga.dart';

class MangaLocalRepository {
  final MangaLocalData mangaLocalData;
  MangaLocalRepository(this.mangaLocalData);

  Future<void> saveManga(Manga manga) async{
    await mangaLocalData.saveManga(manga);
  }

  bool exist(int id){
    return mangaLocalData.exist(id);
  }
  Future<void> delete(int id) async {
    await mangaLocalData.delete(id);
  }

  Manga? getManga(int id){
    mangaLocalData.getManga(id);
  }

  List<Manga> getAllFavoriteManga(){
    return mangaLocalData.getAllManga();
  }
}