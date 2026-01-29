import '../../utils/Manga.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  List<Manga> call() {
    return repository.getCartItems();
  }
}
