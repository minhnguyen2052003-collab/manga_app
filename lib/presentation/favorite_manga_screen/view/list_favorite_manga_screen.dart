import 'package:flutter/material.dart';

import 'package:comic_app_gpt/features/manga/presentation/provider/favorite_manga_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/list_manga_screen/widget/manga_item_widget.dart';

class ListFavoriteMangaScreen extends ConsumerWidget {
  const ListFavoriteMangaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listFavorite = ref.watch(favoriteMangaProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách yêu thích",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: listFavorite.isEmpty
          ? Center(child: Text("Nothing..."))
          : GridView.builder(
              // Gắn controller vào đây
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, // Tỉ lệ chiều rộng/cao của ô truyện
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              // Cộng thêm 1 ô ở cuối để chứa cái vòng quay Loading khi đang kéo
              itemCount: listFavorite.length,
              itemBuilder: (context, index) {

                final manga = listFavorite[index];
                return MangaItemWidget(manga: manga); // Widget cũ của bạn
              },
            ),
    );
  }
}
