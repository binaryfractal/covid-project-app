// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final typeId = 3;

  @override
  Question read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as String,
      order: fields[1] as int,
      question: fields[2] as String,
      type: fields[3] as String,
      subQuestion: fields[4] as bool,
      answer: fields[5] as String,
      answers: (fields[6] as List)?.cast<Answer>(),
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.order)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.subQuestion)
      ..writeByte(5)
      ..write(obj.answer)
      ..writeByte(6)
      ..write(obj.answers);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as String,
    order: json['order'] as int,
    question: json['question'] as String,
    type: json['type'] as String,
    subQuestion: json['subQuestion'] as bool,
    answer: json['answer'] as String,
    answers: (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'question': instance.question,
      'type': instance.type,
      'subQuestion': instance.subQuestion,
      'answer': instance.answer,
      'answers': instance.answers,
    };
