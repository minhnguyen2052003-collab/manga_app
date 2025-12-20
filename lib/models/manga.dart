import 'package:comic_app_gpt/models/category.dart';
import 'package:comic_app_gpt/models/manga_attribute.dart';
import 'dart:math';

class Manga {
  final String id;
  final String type;
  final MangaAttributes attributes;
  final double rating;
  final int? price;

  Manga({
    required this.id,
    required this.type,
    required this.attributes,
    required this.rating,
    required this.price

  });

  factory Manga.fromJson(Map<String, dynamic> json) {

    final random = Random();
    return Manga(
      id: json['id'],
      type: json['type'],
      attributes: MangaAttributes.fromJson(json['attributes']),
      rating: double.parse((4 + Random().nextDouble()).toStringAsFixed(1)),
        price: 100000 + random.nextInt(100001)
        
      );
  }
}