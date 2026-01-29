import 'package:comic_app_gpt/features/manga/data/models/manga.dart';
import 'package:comic_app_gpt/core/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:comic_app_gpt/features/manga/data/models/poster_image.dart';

class BasicInforMangaWidget extends StatelessWidget{
  const BasicInforMangaWidget({super.key, required this.selectedManga, required this.isBuying});

  final Manga selectedManga;
  final bool isBuying;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              selectedManga.attributes.posterImage.tiny ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedManga.attributes.canonicalTitle ?? "Unknown",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  _inforComic(selectedManga.attributes.status ?? "Unknown", "Tình Trạng:"),
                  SizedBox(height: 6),
                  _inforComic(selectedManga.attributes.chapterCount.toString(), "Chapters:"),
                  SizedBox(height: 6),
                  _inforComic(
                    selectedManga.attributes.updatedAt ?? "Unknown",
                    "Cập nhật:",
                  ),
                  SizedBox(height: 6),
                  TagsWidget(selectedManga: selectedManga,),
                  SizedBox(height: 10,),
                  if(isBuying)
                  Text("Giá: ${selectedManga.price}đ", style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inforComic(String subTitle, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            subTitle,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ],
    );
  }
}