// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FireBaseAnswerModelAdapter extends TypeAdapter<FireBaseAnswerModel> {
  @override
  final int typeId = 0;

  @override
  FireBaseAnswerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FireBaseAnswerModel(
      kgKeyWord: fields[0] as String,
      enKeyWord: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FireBaseAnswerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.kgKeyWord)
      ..writeByte(1)
      ..write(obj.enKeyWord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FireBaseAnswerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
