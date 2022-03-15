// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineData _$TimelineDataFromJson(Map<String, dynamic> json) => TimelineData(
      artifacts: (json['artifacts'] as List<dynamic>)
          .map((e) => ArtifactData.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>)
          .map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimelineDataToJson(TimelineData instance) =>
    <String, dynamic>{
      'artifacts': instance.artifacts,
      'events': instance.events,
    };

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) =>
    TimelineEvent(
      title: json['title'] as String,
      string: json['string'] as String,
      image: json['image'] as String,
      year: json['year'] as int,
    );

Map<String, dynamic> _$TimelineEventToJson(TimelineEvent instance) =>
    <String, dynamic>{
      'year': instance.year,
      'title': instance.title,
      'string': instance.string,
      'image': instance.image,
    };
