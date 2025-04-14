// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarModelAdapter extends TypeAdapter<CarModel> {
  @override
  final int typeId = 0;

  @override
  CarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarModel(
      code: fields[0] as String,
      name: fields[2] as String,
      description: fields[4] as String,
      price: fields[5] as int,
      image: fields[6] as String,
      brand: fields[1] as String,
      color: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
