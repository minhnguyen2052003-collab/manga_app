import 'package:comic_app_gpt/domain/usecase/add_to_cart.dart';
import 'package:comic_app_gpt/domain/usecase/get_cart_items.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_event.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Manga.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  final AddToCartUseCase addComicToCartUseCase;
  final GetCartUseCase getCartUseCase;
  CartBloc({required this.addComicToCartUseCase,required this.getCartUseCase}):super(CartInitial()){
    on<LoadCart>(_onLoadCart);
    on<AddComicToCart>(_onAddComicToCart);
    add(LoadCart());
  }
  Future<void> _onLoadCart(
      LoadCart event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      final items =  getCartUseCase();
      emit(CartLoaded(items));
    } catch (_) {
      emit(CartError('Không load được giỏ hàng'));
    }
  }
  Future<void> _onAddComicToCart(
      AddComicToCart event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      await addComicToCartUseCase(event.manga);
      final items = getCartUseCase();

      emit(CartLoaded(items));
    } catch (_) {
      emit(CartError('Không thể thêm truyện'));
    }
  }
}

