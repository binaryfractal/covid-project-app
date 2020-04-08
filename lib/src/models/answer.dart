import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Answer extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String answer;
  @HiveField(2)
  final int order;
  @HiveField(3)
  final String idQuestion;

  Answer({this.id, this.answer, this.order, this.idQuestion});

  @override
  List<Object> get props => [id, answer, order, idQuestion];

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  bool get stringify => true;
}
