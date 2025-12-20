import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comic_app_gpt/providers/list_manga_selected_provider.dart';

import '../widgets/manga_item_widget.dart';


class SearchMangaScreen extends ConsumerStatefulWidget {
  const SearchMangaScreen({
    super.key,
    required this.keyword,
  });

  final String keyword;

  @override
  ConsumerState<SearchMangaScreen> createState() =>
      _SearchMangaScreenState();
}
class _SearchMangaScreenState
    extends ConsumerState<SearchMangaScreen> {
 final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();


    _scrollController.addListener(_onScroll);

    Future.microtask(() {
      ref
          .read(searchMangaProvider.notifier)
          .search(widget.keyword);
    });
  }
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchMangaProvider.notifier).loadMore();
    }
  }
  @override
  void dispose() {
    _scrollController
        .removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchMangaProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả "${widget.keyword}"'),
      ),
      body: _buildBody(state),
    );
  }
  Widget _buildBody(SearchMangaState state) {
    // ⏳ Loading lần đầu
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.data.isEmpty) {
      return const Center(
        child: Text('Không tìm thấy truyện'),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      // Gắn controller vào đây
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65, // Tỉ lệ chiều rộng/cao của ô truyện
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      // Cộng thêm 1 ô ở cuối để chứa cái vòng quay Loading khi đang kéo
      itemCount: state.data.length + (state.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        // Nếu là ô cuối cùng và đang tải -> Hiện vòng quay
        if (index == state.data.length) {
          return const Center(child: CircularProgressIndicator());
        }

        // Còn lại thì hiện truyện như bình thường
        final manga =state.data[index];
        return MangaItemWidget(manga: manga);
      },
    );
  }
}
