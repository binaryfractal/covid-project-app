// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final typeId = 0;

  @override
  Country read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      id: fields[0] as String,
      name: fields[1] as String,
      nameApi: fields[2] as String,
      confirmed: fields[3] as int,
      recovered: fields[4] as int,
      risk: fields[5] as int,
      riskFree: fields[6] as int,
      riskHigh: fields[7] as int,
      riskLow: fields[8] as int,
      total: fields[9] as int,
      deaths: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameApi)
      ..writeByte(3)
      ..write(obj.confirmed)
      ..writeByte(4)
      ..write(obj.recovered)
      ..writeByte(5)
      ..write(obj.risk)
      ..writeByte(6)
      ..write(obj.riskFree)
      ..writeByte(7)
      ..write(obj.riskHigh)
      ..writeByte(8)
      ..write(obj.riskLow)
      ..writeByte(9)
      ..write(obj.total)
      ..writeByte(10)
      ..write(obj.deaths);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    id: json['id'] as String,
    name: json['name'] as String,
    nameApi: json['nameApi'] as String,
    confirmed: json['confirmed'] as int,
    recovered: json['recovered'] as int,
    risk: json['risk'] as int,
    riskFree: json['riskFree'] as int,
    riskHigh: json['riskHigh'] as int,
    riskLow: json['riskLow'] as int,
    total: json['total'] as int,
    deaths: json['deaths'] as int,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameApi': instance.nameApi,
      'confirmed': instance.confirmed,
      'recovered': instance.recovered,
      'risk': instance.risk,
      'riskFree': instance.riskFree,
      'riskHigh': instance.riskHigh,
      'riskLow': instance.riskLow,
      'total': instance.total,
      'deaths': instance.deaths,
    };
