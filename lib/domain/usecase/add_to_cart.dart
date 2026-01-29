import 'package:comic_app_gpt/domain/repository/cart_repository.dart';
import 'package:comic_app_gpt/utils/Manga.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;
  AddToCartUseCase(this.cartRepository);

  Future<void> call(Manga manga)async{
    await cartRepository.addToCart(manga);

  }
}