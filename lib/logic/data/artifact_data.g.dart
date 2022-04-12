// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtifactData _$ArtifactDataFromJson(Map<String, dynamic> json) => ArtifactData(
      objectId: json['objectId'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      year: json['year'] as int,
      yearStr: json['year'] as String,
      date: json['objectDate'] as String,
      objectType: json['objectType'] as String,
      period: json['period'] as String,
      country: json['country'] as String,
      medium: json['medium'] as String,
      dimension: json['dimension'] as String,
      classification: json['classification'] as String,
      culture: json['culture'] as String,
    );

Map<String, dynamic> _$ArtifactDataToJson(ArtifactData instance) => <String, dynamic>{
      'objectID': instance.objectId,
      'title': instance.title,
      'image': instance.image,
      'year': instance.year,
      'yearStr': instance.yearStr,
      'objectDate': instance.date,
      'objectType': instance.objectType,
      'period': instance.period,
      'country': instance.country,
      'medium': instance.medium,
      'dimension': instance.dimension,
      'classification': instance.classification,
      'culture': instance.culture,
    };
