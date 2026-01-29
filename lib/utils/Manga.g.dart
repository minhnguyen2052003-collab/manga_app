// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Manga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaAdapter extends TypeAdapter<Manga> {
  @override
  final int typeId = 0;

  @override
  Manga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Manga(
      id: fields[0] as String,
      type: fields[1] as String,
      attributes: fields[2] as MangaAttributes,
      rating: fields[3] as double,
      price: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Manga obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.attributes)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
