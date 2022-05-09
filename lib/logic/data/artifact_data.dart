class ArtifactData {
  ArtifactData({
    required this.objectId,
    required this.title,
    required this.image,
    required this.date,
    required this.period,
    required this.country,
    required this.medium,
    required this.dimension,
    required this.classification,
    required this.culture,
    required this.objectType,
    required this.objectBeginYear,
    required this.objectEndYear,
  });
  final String objectId; // Artifact ID, used to identify through MET server calls.
  final String title; // Artifact title / name
  final String image; // Artifact primary image URL (can have multiple)
  final int objectBeginYear; // Artifact creation year start.
  final int objectEndYear; // Artifact creation year end.
  final String objectType; // Type of thing (coin, basic, cup etc)

  final String date; // Date of creation
  final String period; // Time period of creation
  final String country; // Country of origin
  final String medium; // Art medium
  final String dimension; // Width and height of physical artifact
  final String classification; // Type of artifact
  final String culture; // Culture of artifact
}
