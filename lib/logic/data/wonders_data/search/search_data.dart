class SearchData {
  static const String baseImagePath = 'https://images.metmuseum.org/CRDImages/';

  const SearchData(this.year, this.id, this.title, this.keywords, this.imagePath);
  final int year;
  final int id;
  final String imagePath;
  final String keywords;
  final String title;

  String get imageUrl => baseImagePath + imagePath;
}