import 'package:comic_app_gpt/models/poster_image.dart';

class MangaAttributes {
  final String? createdAt;
  final String? updatedAt;
  final String? canonicalTitle;
  final String? averageRating;
  final int? userCount;
  final int? favoriteCount;
  final String? status;
  final PosterImage posterImage;
  final int? chapterCount;
  final String? description;

  MangaAttributes({
    required this.posterImage,
    required this.updatedAt,
    required this.status,
    required this.averageRating,
    required this.canonicalTitle,
    required this.chapterCount,
    required this.createdAt,
    required this.favoriteCount,
    required this.userCount,
    required this.description
  });

  factory MangaAttributes.fromJson(Map<String, dynamic> json){
    return MangaAttributes(posterImage:  PosterImage.fromJson(json['posterImage']),
        updatedAt: json["updatedAt"],
        status: json["status"],
        averageRating: json["averageRating"],
        canonicalTitle: json["canonicalTitle"],
        chapterCount: json["chapterCount"],
        createdAt: json["createdAt"],
        favoriteCount: json["favoriteCount"] ?? 0,
        userCount: json["userCount"] ?? 0,
      description: json["description"] ?? "Unknown"
    );
  }
}
