
import 'package:dio/dio.dart';

import '../utils/category.dart';

class TagApi {
  final Dio dio;
  TagApi(this.dio);

  Future<List<Category>> fetchCategories(String id) async {
    final response = await dio.get(
      "/edge/manga/$id/categories",

    );
    final List list = response.data["data"];

    List<Category> listCategories = list.map((i) => Category.fromJson(i)).toList();

    return listCategories;
  }

}