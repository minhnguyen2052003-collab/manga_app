import '../../../../domain/repository/manga_repository.dart';
import '../../data/models/manga.dart';

class MangaController {
  final MangaRepository repository;

  static const int _limit = 20;
  int _offset = 0;
  bool _isFetching = false;
  bool _hasMore = true;
  MangaController(this.repository);

  Future<List<Manga>> loadFirstPage({String? keyword, String? slug}) async {
    _offset = 0;
    _hasMore = true;

    return _fetchNext(keyword: keyword, slug: slug);
  }

  Future<List<Manga>> loadNextPage({String? keyword, String? slug}) async {
    if (_isFetching || !_hasMore) return [];

    return _fetchNext(keyword: keyword,slug: slug);
  }

  Future<List<Manga>> _fetchNext({String? keyword, String? slug}) async {
    _isFetching = true;

    final page = await repository.getMangaPage(
      limit: _limit,
      offset: _offset,
      keyword: keyword,
      slug: slug
    );

    _isFetching = false;

    if (page.isEmpty) {
      _hasMore = false;
      return [];
    }

    _offset += _limit;
    return page;
  }
}
