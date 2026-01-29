
import 'package:comic_app_gpt/presentation/list_manga_screen/modelview/state_list_manga_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modelview/category_provider.dart';

class AppDrawerWidget extends ConsumerStatefulWidget{
  const AppDrawerWidget({super.key});

  @override
  ConsumerState<AppDrawerWidget> createState() {
    return _AppDrawerWidgetState();
  }
}

class _AppDrawerWidgetState extends ConsumerState<AppDrawerWidget>{
  final scrollController = ScrollController();
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(cateProvider.notifier).loadFirt());
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
        ref
            .read(cateProvider.notifier)
            .loadNext();
    }
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cateState = ref.watch(cateProvider);
    final state = ref.watch(stateListMangaProvider);
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Center(
                child: Text(
                  "Thể Loại",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ...cateState.listCate.map((category) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(category.title ?? " "),
                onTap: () {
                  ref.read(stateListMangaProvider.notifier).loadWithCategory(category.slug!);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      );
  }


}