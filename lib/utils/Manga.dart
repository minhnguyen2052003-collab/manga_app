
import 'dart:math';
import 'package:hive/hive.dart';
import 'manga_attribute.dart';
part "Manga.g.dart";


@HiveType(typeId: 0)
class Manga {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final MangaAttributes attributes;
  @HiveField(3)
  final double rating;
  @HiveField(4)
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