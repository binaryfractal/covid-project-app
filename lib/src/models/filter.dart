import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class Filter extends Equatable {
  final String name;
  final String comparator;
  final String value;
  final List<String> values;
  final int limit;

  Filter({this.name, this.comparator, this.value, this.values, this.limit});

  @override
  List<Object> get props => [name, comparator, value, values, limit];

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);

  @override
  bool get stringify => true;
}
