// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      category: fields[1] as String,
      name: fields[2] as String,
      picture: fields[3] as String,
      price: fields[4] as double,
      duration: fields[5] as double,
      hintTitle: fields[6] as String,
      hintDescription: fields[7] as String,
    )..count = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.picture)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.hintTitle)
      ..writeByte(7)
      ..write(obj.hintDescription)
      ..writeByte(8)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
