import 'package:json_annotation/json_annotation.dart';

part 'artifact_data.g.dart';

@JsonSerializable()
class ArtifactData {
  ArtifactData({
    required this.objectId,
    required this.title,
    required this.image,
    required this.year,
    required this.yearStr,
    required this.date,
    required this.period,
    required this.country,
    required this.medium,
    required this.dimension,
    required this.classification,
    required this.culture,
    required this.objectType,
  });
  final int objectId; // Artifact ID, used to identify through MET server calls.
  final String title; // Artifact title / name
  final String image; // Artifact primary image URL (can have multiple)
  final int year; // Base year number. If negative, it's B.C. If positive, it's A.D.
  final String yearStr; // Year from the API can have extras like 'ca. 1995'. Parsed to int, but the raw is stored here.
  final String objectType; // Type of thing (coin, basic, cup etc)

  final String date; // Date of creation
  final String period; // Time period of creation
  final String country; // Country of origin
  final String medium; // Art medium
  final String dimension; // Width and height of physical artifact
  final String classification; // Type of artifact
  final String culture; // Culture of artifact

  factory ArtifactData.fromJson(Map<String, dynamic> json) => _$ArtifactDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArtifactDataToJson(this);
}
