import 'package:json_annotation/json_annotation.dart';

part 'artifact_data.g.dart';

@JsonSerializable()
class ArtifactData {
  ArtifactData({
    required this.objectID,
    required this.title,
    required this.desc,
    required this.image,
    required this.year,
  });
  final int objectID;
  final String title;
  final String desc;
  final String image;
  final String year; // Year from the API can have extra elements like 'ca.' and 'around'.

  ArtifactData.empty(
      {this.objectID = -1, this.title = 'Untitled', this.desc = 'Artifact Not Found', this.image = '', this.year = ''});

  factory ArtifactData.fromJson(Map<String, dynamic> json) => _$ArtifactDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactDataToJson(this);
}
