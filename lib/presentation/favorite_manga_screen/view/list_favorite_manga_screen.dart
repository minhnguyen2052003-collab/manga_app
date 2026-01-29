import 'package:comic_app_gpt/presentation/detail_manga_screen/modelview/favor_manga_controller.dart';
import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../detail_manga_screen/modelview/favorite_manga_provider.dart';
import '../../list_manga_screen/widget/manga_item_widget.dart';

class ListFavoriteMangaScreen extends ConsumerWidget {
  const ListFavoriteMangaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(favorMangaController);
  List<Manga> listFavorite = controller.getFavorManga();

    return listFavorite.isEmpty
        ? Center(child: Text("Nothing..."))
        : GridView.builder(
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
        return MangaItemWidget(manga: manga);
      },
    );
  }
}
