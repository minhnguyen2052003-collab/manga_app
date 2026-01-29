import 'package:comic_app_gpt/features/manga/data/models/manga.dart';
import 'package:comic_app_gpt/features/manga/data/manga_api.dart';

class MangaRepository {
  final MangaApi mangaApi ;
  MangaRepository(this.mangaApi);

  Future<List<Manga>> getMangaPage({
    int limit = 20,
    int offset = 0,
    String? keyword,
    String? slug
})async{

    return await mangaApi.fetchMangaPage(limit: limit, offset: offset, keyword: keyword, slug: slug );
  }
}