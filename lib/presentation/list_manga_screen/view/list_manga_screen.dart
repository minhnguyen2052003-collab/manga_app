import 'package:comic_app_gpt/domain/repository/cart_repository.dart';
import 'package:comic_app_gpt/domain/usecase/add_to_cart.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_bloc.dart';
import 'package:comic_app_gpt/presentation/cart_creen/view/cart_screen.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/widget/app_drawer_widget.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/modelview/state_list_manga_provider.dart';
import 'package:comic_app_gpt/presentation/login_screen/modelview/login_controller.dart';
import 'package:comic_app_gpt/presentation/login_screen/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comic_app_gpt/presentation/list_manga_screen/widget/manga_item_widget.dart';
import '../../favorite_manga_screen/view/list_favorite_manga_screen.dart';
import '../modelview/manga_controller.dart';

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
    return state.isLoading && state.listManga.isEmpty
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
    );


  }
}
