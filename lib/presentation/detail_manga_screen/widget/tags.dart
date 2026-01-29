import 'package:comic_app_gpt/features/manga/data/models/category.dart';
import 'package:comic_app_gpt/features/manga/data/models/manga.dart';
import 'package:comic_app_gpt/services/categories_api.dart';
import 'package:flutter/material.dart';
import 'package:comic_app_gpt/domain/service/manga_api.dart';

import '../network/dio_client.dart';

class TagsWidget extends StatelessWidget{
   const TagsWidget({super.key, required this.selectedManga});
  final Manga selectedManga;

  @override
  Widget build(BuildContext context) {

    final dio = DioClient.dio;

    return FutureBuilder(
        future: CategoriesApi(dio).fetchCategories(selectedManga.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Lỗi: ${snapshot.error}");
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Text("Không có thể loại nào");
          }
          final List<Category> listCategories = snapshot.data as List<Category>;

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...List.generate(listCategories.length > 4 ? 4 : listCategories.length, (index,) {
                final genre = listCategories[index].title;
                return GestureDetector(
                  onTap: () {},

                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(
                        20,
                      ),
                      color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),

                    child: Text(
                      genre ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        }
    );
  }
}