// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    name: json['name'] as String,
    comparator: json['comparator'] as String,
    value: json['value'] as String,
    values: (json['values'] as List)?.map((e) => e as String)?.toList(),
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'name': instance.name,
      'comparator': instance.comparator,
      'value': instance.value,
      'values': instance.values,
      'limit': instance.limit,
    };
