import 'package:comic_app_gpt/models/manga.dart';

class KitsuMangaResponse {
  final List<Manga> data;

  KitsuMangaResponse({required this.data});

  factory KitsuMangaResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Manga> mangaList = list.map((i) => Manga.fromJson(i)).toList();

    return KitsuMangaResponse(data: mangaList);
  }
}