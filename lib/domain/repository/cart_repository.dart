import 'package:comic_app_gpt/domain/service/cart_data_local.dart';

import '../../utils/Manga.dart';

abstract class CartRepository {
  Future<void> addToCart(Manga manga);
  List<Manga> getCartItems();


}

class CartRepositoryImpl extends CartRepository{
  final CartData cartData;
  CartRepositoryImpl(this.cartData);


  @override
  Future<void> addToCart(Manga manga) async {
    await cartData.saveMangaToCart(manga);


  }

  @override
  List<Manga> getCartItems() {

    return cartData.getAllMangaFromCart();

  }

}
