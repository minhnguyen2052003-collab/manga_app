import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:hive/hive.dart';

class CartData {
  final Box<Manga> box;
  CartData(this.box);

  Future<void> saveMangaToCart(Manga manga) async {
    await box.put(manga.id, manga);
  }

  Future<void> deleteMangaFromCart(int id) async {
    await box.delete(id);
  }

  List<Manga> getAllMangaFromCart(){
    return box.values.toList();
  }
}