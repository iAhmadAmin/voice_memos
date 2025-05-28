// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordingImpl _$$RecordingImplFromJson(Map<String, dynamic> json) =>
    _$RecordingImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      filePath: json['filePath'] as String,
      duration: (json['duration'] as num).toInt(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$$RecordingImplToJson(_$RecordingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'filePath': instance.filePath,
      'duration': instance.duration,
      'dateCreated': instance.dateCreated.toIso8601String(),
    };
