import 'package:wonders/common_libs.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey,
      ),
      child: Icon(Icons.image_outlined, color: Colors.grey.shade600, size: 48),
    );
  }
}
