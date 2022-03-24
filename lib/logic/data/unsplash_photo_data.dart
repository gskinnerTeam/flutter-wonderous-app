class UnsplashPhotoData {
  UnsplashPhotoData({required this.id, required this.width, required this.height, required this.url});
  final String id;
  final int width;
  final int height;
  final String url;
  late final double aspect = width / height;

  String? getSizedUrl(int? targetSize) => '$url?q=90&fm=jpg${targetSize != null ? '&w=$targetSize' : ''}&fit=max';
}
