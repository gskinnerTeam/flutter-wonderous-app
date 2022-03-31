// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtifactData _$ArtifactDataFromJson(Map<String, dynamic> json) => ArtifactData(
      objectId: json['objectId'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String,
      image: json['image'] as String,
      year: json['year'] as int,
      yearStr: json['year'] as String,
    );

Map<String, dynamic> _$ArtifactDataToJson(ArtifactData instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'title': instance.title,
      'desc': instance.desc,
      'image': instance.image,
      'year': instance.year,
      'yearStr': instance.yearStr,
    };
