import 'package:comic_app_gpt/features/manga/presentation/provider/favorite_manga_list_provider.dart';
import 'package:comic_app_gpt/features/manga/presentation/provider/status_star_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/manga/data/models/manga.dart';

class FavoriteStarWidget extends ConsumerStatefulWidget {
  const FavoriteStarWidget({super.key, required this.selectedManga});

  final Manga selectedManga;

  @override
  ConsumerState<FavoriteStarWidget> createState() {
    return _FavoriteStarWidgetState();
  }
}

class _FavoriteStarWidgetState extends ConsumerState<FavoriteStarWidget> {


  @override
  Widget build(BuildContext context) {

    bool status = ref.watch(statusStarProvider);
    List<Manga> listManga = ref.watch(favoriteMangaProvider);

    if(!listManga.contains(widget.selectedManga)){
      status = false;
    }

    return IconButton(
      onPressed: () {
        if(status == false){
          ref.read(statusStarProvider.notifier).addedStatus();
          ref.read(favoriteMangaProvider.notifier).addToList(widget.selectedManga);
        }else{
          ref.read(statusStarProvider.notifier).removedStatus();
          ref.read(favoriteMangaProvider.notifier).removeFromList(widget.selectedManga);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status == true ? "Removed" : "Added"),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      icon: Icon(status ? Icons.star : Icons.star_border),
      style: IconButton.styleFrom(
        foregroundColor: Colors.amber,
        iconSize: 32,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
    );
  }
}
