class SearchData {
  static const String baseImagePath = 'https://images.metmuseum.org/CRDImages/';

  const SearchData(this.year, this.id, this.title, this.keywords, this.imagePath, [this.aspectRatio = 0]);
  final int year;
  final int id;
  final String imagePath;
  final String keywords;
  final String title;
  final double aspectRatio;

  String get imageUrl => baseImagePath + imagePath;

  // used by the search helper tool:
  String write() =>
      "SearchData($year, $id, '$title', '$keywords', '$imagePath'${aspectRatio == 0 ? '' : ', ${aspectRatio.toStringAsFixed(2)}'})";
}
