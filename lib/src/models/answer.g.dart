// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerAdapter extends TypeAdapter<Answer> {
  @override
  final typeId = 4;

  @override
  Answer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answer(
      id: fields[0] as String,
      answer: fields[1] as String,
      order: fields[2] as int,
      idQuestion: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.order)
      ..writeByte(3)
      ..write(obj.idQuestion);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['id'] as String,
    answer: json['answer'] as String,
    order: json['order'] as int,
    idQuestion: json['idQuestion'] as String,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'order': instance.order,
      'idQuestion': instance.idQuestion,
    };
