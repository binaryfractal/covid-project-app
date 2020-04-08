// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Risk _$RiskFromJson(Map<String, dynamic> json) {
  return Risk(
    id: json['id'] as String,
    name: json['name'] as String,
    minRange: json['minRange'] as int,
    maxRange: json['maxRange'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$RiskToJson(Risk instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'minRange': instance.minRange,
      'maxRange': instance.maxRange,
      'message': instance.message,
    };
