class UnsplashPhotoData {
  static const String unsplashUrl = 'https://unsplash.com/?utm_source=wonders&utm_medium=referral';
  UnsplashPhotoData({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.ownerName,
    required this.ownerUsername,
  });
  final String id;
  final int width;
  final int height;
  final String url;
  final String ownerName;
  final String ownerUsername;
  late final double aspect = width / height;

  late final String photographerUrl = 'https://unsplash.com/@$ownerUsername?utm_source=wonders&utm_medium=referral';

  String? getSizedUrl(int? targetSize) => '$url?q=85&fm=jpg${targetSize != null ? '&w=$targetSize' : ''}&fit=max';
}
