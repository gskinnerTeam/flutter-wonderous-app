// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtifactData _$ArtifactDataFromJson(Map<String, dynamic> json) => ArtifactData(
      objectID: json['objectID'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String,
      image: json['image'] as String,
      year: json['year'] as String,
    );

Map<String, dynamic> _$ArtifactDataToJson(ArtifactData instance) => <String, dynamic>{
      'objectID': instance.objectID,
      'title': instance.title,
      'desc': instance.desc,
      'image': instance.image,
      'year': instance.year,
    };
