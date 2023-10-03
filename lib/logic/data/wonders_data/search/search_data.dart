import 'package:wonders/logic/data/artifact_data.dart';

class SearchData {
  const SearchData(this.year, this.id, this.title, this.keywords, [this.aspectRatio = 0]);

  final int year;
  final int id;
  final String keywords;
  final String title;
  final double aspectRatio;

  String get imageUrl => ArtifactData.getSelfHostedImageUrl('$id');
  String get imageUrlSmall => ArtifactData.getSelfHostedImageUrlSmall('$id');

  // used by the search helper tool:
  String write() => "SearchData($year, $id, '$title', '$keywords')";
}
