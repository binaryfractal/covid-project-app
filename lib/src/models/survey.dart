import 'package:covidapp/src/models/question.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Survey extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final List<Question> questions;

  Survey({this.id, this.name, this.date, this.questions});

  @override
  List<Object> get props => [id, name, date, questions];

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  @override
  bool get stringify => true;
}
