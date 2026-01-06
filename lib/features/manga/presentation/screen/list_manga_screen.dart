import 'package:comic_app_gpt/core/widgets/app_drawer_widget.dart';
import 'package:comic_app_gpt/features/manga/presentation/provider/category_state_provider.dart';
import 'package:comic_app_gpt/features/manga/presentation/provider/state_list_manga_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:comic_app_gpt/features/manga/data/manga_repository.dart';
import 'package:comic_app_gpt/features/manga/data/manga_api.dart';
import 'package:comic_app_gpt/core/widgets/manga_item_widget.dart';
import '../../data/models/manga.dart';
import '../controller/manga_controller.dart';

class ListMangaScreen extends ConsumerStatefulWidget {
  const ListMangaScreen({super.key});

  @override
  ConsumerState<ListMangaScreen> createState() => _ListMangaScreenState();
}

class _ListMangaScreenState extends ConsumerState<ListMangaScreen> {
  final ScrollController _scrollController = ScrollController();
  final controller = TextEditingController();
  bool isSearching = false;
  bool isCategory = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(stateListMangaProvider.notifier).loadHome();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(stateListMangaProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stateListMangaProvider);
    String? appBarTitle = state.title;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          child: isSearching
              ? TextField(
                  controller: controller,
                  key: ValueKey("searching"),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm....",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    ref
                        .read(stateListMangaProvider.notifier)
                        .loadWithText(value);
                  },
                  onSubmitted: (value) {
                    setState(() {
                      appBarTitle = state.title!;
                      isSearching = false;
                    });
                  },
                )
              : Text(
                  appBarTitle!,
                  key: ValueKey("init"),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  controller.clear();
                  ref
                      .read(stateListMangaProvider.notifier)
                      .loadWithText(controller.text);
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),

      drawer: AppDrawerWidget(),
      body: state.isLoading && state.listManga.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
              ),
              itemCount: state.listManga.length,
              itemBuilder: (context, index) {
                if (index == state.listManga.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final manga = state.listManga[index];
                return MangaItemWidget(manga: manga);
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      appBarTitle = "Danh sách truyện";
                      ref
                          .read(stateListMangaProvider.notifier)
                          .loadHome();
                    });
                  },
                  icon: const Icon(Icons.home),
                  style: IconButton.styleFrom(iconSize: 32),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (ctx) => ListFavoriteMangaScreen()));
                  },
                  icon: const Icon(Icons.star),
                  style: IconButton.styleFrom(
                    iconSize: 32,
                    foregroundColor: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
