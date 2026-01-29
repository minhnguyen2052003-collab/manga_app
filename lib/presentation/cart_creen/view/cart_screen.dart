import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_bloc.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_event.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/widget/manga_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart_creen/bloc/cart_state.dart';

class CartMangaScreen extends StatelessWidget {
  const CartMangaScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CartLoaded) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Giỏ hàng trống'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65, // Tỉ lệ chiều rộng/cao của ô truyện
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            // Cộng thêm 1 ô ở cuối để chứa cái vòng quay Loading khi đang kéo
            itemCount: state.items.length,
            itemBuilder: (context, index) {

              final manga = state.items[index];
              return MangaItemWidget(manga: manga);
            },
          );
        }

        if (state is CartError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
