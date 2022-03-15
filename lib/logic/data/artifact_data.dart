import 'package:json_annotation/json_annotation.dart';

part 'artifact_data.g.dart';

@JsonSerializable()
class ArtifactData {
  ArtifactData({
    required this.title,
    required this.desc,
    required this.image,
    required this.year,
  });
  final String title;
  final String desc;
  final String image;
  final int year;

  factory ArtifactData.fromJson(Map<String, dynamic> json) => _$ArtifactDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactDataToJson(this);
}
