// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_attribute.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaAttributesAdapter extends TypeAdapter<MangaAttributes> {
  @override
  final int typeId = 1;

  @override
  MangaAttributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaAttributes(
      posterImage: fields[7] as PosterImage,
      updatedAt: fields[1] as String?,
      status: fields[6] as String?,
      averageRating: fields[3] as String?,
      canonicalTitle: fields[2] as String?,
      chapterCount: fields[8] as int?,
      createdAt: fields[0] as String?,
      favoriteCount: fields[5] as int?,
      userCount: fields[4] as int?,
      description: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MangaAttributes obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.canonicalTitle)
      ..writeByte(3)
      ..write(obj.averageRating)
      ..writeByte(4)
      ..write(obj.userCount)
      ..writeByte(5)
      ..write(obj.favoriteCount)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.posterImage)
      ..writeByte(8)
      ..write(obj.chapterCount)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaAttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
