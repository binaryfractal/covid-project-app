import 'package:covidapp/src/models/answer.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Question extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int order;
  @HiveField(2)
  final String question;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final bool subQuestion;
  @HiveField(5)
  final String answer;
  @HiveField(6)
  final List<Answer> answers;

  Question(
      {this.id,
      this.order,
      this.question,
      this.type,
      this.subQuestion,
      this.answer,
      this.answers});

  @override
  List<Object> get props =>
      [order, question, type, subQuestion, answer, answers];

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  bool get stringify => true;
}
