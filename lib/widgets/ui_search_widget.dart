import 'package:flutter/material.dart';

import '../screens/search_manga_screen.dart';



class MangaSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Nhập tên hoặc thể loại';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(
        child: Text('Vui lòng nhập từ khóa'),
      );
    }

    // Đóng Search UI
    close(context, null);

    // Chuyển sang màn hình kết quả
    Future.microtask(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchMangaScreen(
            keyword: query.trim(),
          ),
        ),
      );
    });

    return const SizedBox.shrink();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}


