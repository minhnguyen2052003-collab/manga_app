import 'package:comic_app_gpt/utils/Manga.dart';

sealed class CartState {}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<Manga> items;
  CartLoaded(this.items);
}

class CartError extends CartState{
  final String message;
  CartError(this.message);
}