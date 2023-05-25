// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Job _$$_JobFromJson(Map<String, dynamic> json) => _$_Job(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      tags: json['tags'] as String,
      media: (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      additionalInfo: json['additionalInfo'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );

Map<String, dynamic> _$$_JobToJson(_$_Job instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'description': instance.description,
      'tags': instance.tags,
      'media': instance.media,
      'additionalInfo': instance.additionalInfo,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
