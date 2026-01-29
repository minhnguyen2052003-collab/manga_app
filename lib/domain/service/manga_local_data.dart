import 'dart:math';

import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:hive/hive.dart';

class MangaLocalData {
  final Box<Manga> box;
  MangaLocalData(this.box);

  Future<void> saveManga(Manga manga) async{
    final id = int.parse(manga.id);
    await box.put(id, manga);
  }

  Manga? getManga(int id){
    return box.get(id);
  }

  bool exist(int id){
    return box.containsKey(id);
  }

  Future<void> delete(int id) async {
    await box.delete(id);
  }


  List<Manga> getAllManga(){
    return box.values.toList();

  }
}