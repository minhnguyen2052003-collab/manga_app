import 'package:comic_app_gpt/features/manga/data/models/category.dart';
import 'package:dio/dio.dart';

class CategoriesApi {
  final Dio dio;
  CategoriesApi(this.dio);

  Future<List<Category>> fetchCategories(String id) async {
    final response = await dio.get(
      "/edge/manga/$id/categories",

    );
    final List list = response.data["data"];

    List<Category> listCategories = list.map((i) => Category.fromJson(i)).toList();

    return listCategories;
  }

}