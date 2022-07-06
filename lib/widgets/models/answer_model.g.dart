// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerModelAdapter extends TypeAdapter<AnswerModel> {
  @override
  final int typeId = 0;

  @override
  AnswerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerModel(
      word: fields[0] as String,
      isCorrectAnswer: fields[1] == null ? false : fields[1] as bool,
    )
      ..synonyms =
          fields[2] == null ? [] : (fields[2] as List?)?.cast<dynamic>()
      ..examples =
          fields[3] == null ? [] : (fields[3] as List?)?.cast<dynamic>()
      ..translates =
          fields[4] == null ? [] : (fields[4] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, AnswerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.isCorrectAnswer)
      ..writeByte(2)
      ..write(obj.synonyms)
      ..writeByte(3)
      ..write(obj.examples)
      ..writeByte(4)
      ..write(obj.translates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
