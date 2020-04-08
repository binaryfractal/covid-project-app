// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyAdapter extends TypeAdapter<Survey> {
  @override
  final typeId = 2;

  @override
  Survey read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Survey(
      id: fields[0] as String,
      name: fields[1] as String,
      date: fields[2] as DateTime,
      questions: (fields[3] as List)?.cast<Question>(),
    );
  }

  @override
  void write(BinaryWriter writer, Survey obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.questions);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return Survey(
    id: json['id'] as String,
    name: json['name'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    questions: (json['questions'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'questions': instance.questions,
    };
