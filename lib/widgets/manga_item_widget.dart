import 'package:comic_app_gpt/models/manga.dart';
import 'package:comic_app_gpt/screens/manga_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:comic_app_gpt/services/api_service.dart';



class MangaItemWidget extends StatelessWidget {
  final Manga manga;

  const MangaItemWidget({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => MangaDetailScreen(selectedManga: manga)));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  manga.attributes.posterImage.medium ?? "",
                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                    );
                  },

                  // Hiển thị khi lỗi ảnh
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        
        Text(
          manga.attributes.canonicalTitle ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 2, // Tối đa 2 dòng
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}