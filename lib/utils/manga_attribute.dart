
import 'package:comic_app_gpt/utils/poster_image.dart';
import 'package:hive/hive.dart';
part"manga_attribute.g.dart";

@HiveType(typeId: 1)
class MangaAttributes {
  @HiveField(0)
  final String? createdAt;
  @HiveField(1)
  final String? updatedAt;
  @HiveField(2)
  final String? canonicalTitle;
  @HiveField(3)
  final String? averageRating;
  @HiveField(4)
  final int? userCount;
  @HiveField(5)
  final int? favoriteCount;
  @HiveField(6)
  final String? status;
  @HiveField(7)
  final PosterImage posterImage;
  @HiveField(8)
  final int? chapterCount;
  @HiveField(9)
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