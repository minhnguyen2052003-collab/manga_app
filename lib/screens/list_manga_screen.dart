import 'package:comic_app_gpt/models/category.dart';
import 'package:comic_app_gpt/screens/list_favorite_manga_screen.dart';
import 'package:comic_app_gpt/services/api_service.dart';
import 'package:comic_app_gpt/widgets/manga_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:comic_app_gpt/models/poster_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/manga.dart';
import '../widgets/ui_search_widget.dart';
import 'manga_detail_screen.dart';

class ListMangaScreen extends StatefulWidget {
  const ListMangaScreen({super.key});

  @override
  State<ListMangaScreen> createState() => _ListMangaScreenState();
}

class _ListMangaScreenState extends State<ListMangaScreen> {
  List<Manga> _mangaList = [];
  List<Category> categoryList = [];
  bool _isLoading = false;
  int _currentOffset = 0;

  String? _selectedCategorySlug;
  final ScrollController _scrollController = ScrollController();

  final apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchMoreManga();
    _fetchAllCategories();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreManga();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MangaSearchDelegate());
            },
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ],
        backgroundColor: Colors.white,
        title: const Text(
          "Danh sách truyện",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
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
            ...categoryList.map((category) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(category.title?? " "),
                onTap: () {
                  _onSelectedCategory(category.slug);
                },
              );
            }),
          ],
        ),
      ),

      // ===== BODY =====
      body: _mangaList.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
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
              itemCount: _mangaList.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                // Nếu là ô cuối cùng và đang tải -> Hiện vòng quay
                if (index == _mangaList.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Còn lại thì hiện truyện như bình thường
                final manga = _mangaList[index];
                return MangaItemWidget(manga: manga); // Widget cũ của bạn
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: _resetAllManga,
                  icon: const Icon(Icons.home),
                  style: IconButton.styleFrom(
                    iconSize: 32
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ListFavoriteMangaScreen()));
                  },
                  icon: const Icon(Icons.star),
                  style: IconButton.styleFrom(
                    iconSize: 32,
                    foregroundColor: Colors.amber
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchMoreManga() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Manga> newManga = await ApiService().fetchMangaList(
        limit: 20,
        offset: _currentOffset,
        selectedCategory: _selectedCategorySlug,
      );

      setState(() {
          _mangaList.addAll(newManga);
        _currentOffset += 20;
      });
    } catch (e) {
      print("Lỗi tải thêm truyện: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAllCategories() async {
    try {
      List<Category> allCategories = await apiService.fetchCategories();
      setState(() {
        categoryList = allCategories;
      });
    } catch (e) {
      print("Lỗi tải thể loại : $e");
    }
  }

  void _onSelectedCategory(String? categorySlug) {
    Navigator.pop(context);

    setState(() {
      _selectedCategorySlug = categorySlug;
      _mangaList.clear();
      _currentOffset = 0;
      _isLoading = false;
    });
    _fetchMoreManga();
  }

  void _resetAllManga(){
    setState(() {
      _selectedCategorySlug = null;
      _mangaList.clear();
      _isLoading = false;
    });

    _fetchMoreManga();
  }
}
