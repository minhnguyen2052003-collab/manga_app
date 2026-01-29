
import 'package:comic_app_gpt/presentation/detail_manga_screen/modelview/manga_local_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../utils/Manga.dart';
import '../modelview/favorite_manga_provider.dart';
import '../modelview/status_star_provider.dart';

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

    final state = ref.watch(mangaLocalController(int.parse(widget.selectedManga.id)));




    return IconButton(
      onPressed: () {
        ref.read(mangaLocalController(int.parse(widget.selectedManga.id)).notifier).toggle(widget.selectedManga, int.parse(widget.selectedManga.id));
      },
      icon: Icon( state ? Icons.star : Icons.star_border ),
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
