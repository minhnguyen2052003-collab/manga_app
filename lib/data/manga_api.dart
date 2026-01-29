
import 'package:dio/dio.dart';

import '../utils/Manga.dart';

class MangaApi {
  final Dio dio;

  MangaApi(this.dio);

  Future<List<Manga>> fetchMangaPage({
    int limit = 20,
    int offset = 0,
    String? keyword,
    String? slug
  }) async {
    final response = await dio.get(
      "/edge/manga",
      queryParameters: {
        "page[limit]": limit,
        "page[offset]": offset,
        if (keyword != null && keyword.isNotEmpty) "filter[text]": keyword,
        if(slug != null) "filter[categories]": slug,
      },
    );

    final List list = response.data["data"];

    List<Manga> listManga = list.map((i) => Manga.fromJson(i)).toList();

    return listManga;
  }
}
