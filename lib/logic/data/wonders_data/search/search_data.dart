class SearchData {
  static const String baseImagePath = 'https://images.metmuseum.org/CRDImages/';
  static const missingIds = [313256, 327544, 327596, 545776, 38549, 38578, 38473, 38598, 38153, 38203, 64486, 64487];
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
