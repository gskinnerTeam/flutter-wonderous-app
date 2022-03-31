import 'package:json_annotation/json_annotation.dart';

part 'artifact_data.g.dart';

@JsonSerializable()
class ArtifactData {
  ArtifactData({
    required this.objectId,
    required this.title,
    required this.desc,
    required this.image,
    required this.year,
    required this.yearStr,
  });
  final int objectId;
  final String title;
  final String desc;
  final String image;
  final int year; // Year from the API can have extra elements like 'ca.' and 'around'.
  final String yearStr; // Year from the API can have extra elements like 'ca.' and 'around'.

  factory ArtifactData.fromJson(Map<String, dynamic> json) => _$ArtifactDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactDataToJson(this);
}
