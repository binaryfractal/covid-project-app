// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final typeId = 1;

  @override
  Profile read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      uid: fields[0] as String,
      name: fields[1] as String,
      age: fields[2] as num,
      idCountry: fields[3] as String,
      country: fields[4] as String,
      email: fields[5] as String,
      gender: fields[6] as String,
      idRisk: fields[7] as String,
      risk: fields[8] as String,
      state: fields[9] as String,
      town: fields[10] as String,
      zip: fields[11] as String,
      firstUpdate: fields[12] as DateTime,
      lastUpdate: fields[13] as DateTime,
      surveys: (fields[14] as List)?.cast<Survey>(),
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.idCountry)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.idRisk)
      ..writeByte(8)
      ..write(obj.risk)
      ..writeByte(9)
      ..write(obj.state)
      ..writeByte(10)
      ..write(obj.town)
      ..writeByte(11)
      ..write(obj.zip)
      ..writeByte(12)
      ..write(obj.firstUpdate)
      ..writeByte(13)
      ..write(obj.lastUpdate)
      ..writeByte(14)
      ..write(obj.surveys);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    uid: json['uid'] as String,
    name: json['name'] as String,
    age: json['age'] as num,
    idCountry: json['idCountry'] as String,
    country: json['country'] as String,
    email: json['email'] as String,
    gender: json['gender'] as String,
    idRisk: json['idRisk'] as String,
    risk: json['risk'] as String,
    state: json['state'] as String,
    town: json['town'] as String,
    zip: json['zip'] as String,
    firstUpdate: json['firstUpdate'] == null
        ? null
        : DateTime.parse(json['firstUpdate'] as String),
    lastUpdate: json['lastUpdate'] == null
        ? null
        : DateTime.parse(json['lastUpdate'] as String),
    surveys: (json['surveys'] as List)
        ?.map((e) =>
            e == null ? null : Survey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('name', instance.name);
  writeNotNull('age', instance.age);
  writeNotNull('idCountry', instance.idCountry);
  writeNotNull('country', instance.country);
  writeNotNull('email', instance.email);
  writeNotNull('gender', instance.gender);
  writeNotNull('idRisk', instance.idRisk);
  writeNotNull('risk', instance.risk);
  writeNotNull('state', instance.state);
  writeNotNull('town', instance.town);
  writeNotNull('zip', instance.zip);
  writeNotNull('firstUpdate', instance.firstUpdate?.toIso8601String());
  writeNotNull('lastUpdate', instance.lastUpdate?.toIso8601String());
  writeNotNull('surveys', instance.surveys);
  return val;
}
