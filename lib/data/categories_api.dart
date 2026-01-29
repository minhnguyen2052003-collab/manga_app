import 'package:comic_app_gpt/data/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/category.dart';


class CategoriesApi {
  final Dio dio;

  CategoriesApi(this.dio);

  Future<List<Category>> fetchCategories({int offset = 0, int limit = 20}) async {
    final response = await dio.get(
      "/edge/categories",
      queryParameters: {"page[limit]": limit, "page[offset]": offset},
    );
    final List listData = response.data["data"] ;
    List<Category> list = listData.map( (i) => Category.fromJson(i)).toList();

    return list;


  }
}
final categoriesApiProvider = Provider<CategoriesApi>((ref) => CategoriesApi(DioClient.dio));
