import 'package:comic_app_gpt/models/category.dart';
import 'package:comic_app_gpt/models/kitsu_manga_reponse.dart';
import 'package:comic_app_gpt/models/manga.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://kitsu.io/api/edge/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers:{
      "Accept": "application/vnd.api+json",
      'Content-Type': "application/vnd.api+json"
    }

  ));

  Future<List<Manga>> fetchMangaList({int limit = 20, int offset = 0, String? selectedCategory, String? text}) async {
    try{
      final response = await _dio.get(
        'manga',
        queryParameters: {
          'page[limit]': limit,
          'page[offset]': offset,
          if (selectedCategory != null)
            'filter[categories]': selectedCategory,
          if(text != null)
            "filter[text]": text,
        },
      );

      if(response.statusCode == 200){
        final dataMap = response.data;

        final kitsuResponse = KitsuMangaResponse.fromJson(dataMap);
        return kitsuResponse.data;
      }else{
        throw Exception("Failed to load data.");
      }
    } on DioException catch (e){
      if(e.type == DioExceptionType.connectionTimeout){
        throw Exception("Kết nối gián đoạn (Timeout)");
      }else if(e.response !=  null){
        throw Exception("Lỗi từ sever : ${e.response?.statusCode}");
      }else{
        throw Exception("Lỗi không xác định:${e.message}");
      }
    }
  }


  Future<List<Category>> fetchCategoriesWithId(String id) async {
    try {
      final response = await _dio.get("manga/$id/categories");

      if (response.statusCode == 200) {

        final List<dynamic> dataList = response.data['data'];

        // Map từng phần tử JSON sang object Genre
        return dataList.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi khi tải thể loại: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Xử lý lỗi Dio (như timeout, mất mạng)
      throw Exception('Lỗi kết nối khi lấy Genre: ${e.message}');
    } catch (e) {
      throw Exception('Lỗi không xác định: $e');
    }
  }
  
  
  Future<List<Category>> fetchCategories() async {
    List<Category> allCategories =[];
    int limit = 20;
    int offset= 0;
    try {
      while (true) {
        final response = await _dio.get(
          'categories',
          queryParameters: {
            'page[limit]': limit,
            'page[offset]': offset,
          },
        );

        if (response.statusCode == 200) {
          final List dataList = response.data['data'];

          if (dataList.isEmpty) {
            break;
          }

          allCategories.addAll(
            dataList.map((json) => Category.fromJson(json)).toList(),
          );

          offset += limit;
        } else {
          throw Exception('Lỗi HTTP: ${response.statusCode}');
        }
      }
    } on DioException catch (e) {
      throw Exception('Lỗi khi tải category: ${e.message}');
    }

    return allCategories;
  }
  }