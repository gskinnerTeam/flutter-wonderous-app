import 'dart:ui';

import 'package:wonders/common_libs.dart';

class ArtifactBlurredBg extends StatelessWidget {
  const ArtifactBlurredBg({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        color: context.colors.greyStrong,
      );
    }

    return Container(
      decoration: BoxDecoration(
        // Image
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // Gradient Vertical
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [context.colors.greyStrong, context.colors.greyStrong, Colors.white],
            stops: const [0.0, 0.2, 1.0],
          ),
          backgroundBlendMode: BlendMode.multiply,
        ),
        child: Container(
          decoration: BoxDecoration(
            // Gradient Horizontal
            gradient: LinearGradient(
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
              colors: [context.colors.greyStrong, Colors.white, Colors.white, context.colors.greyStrong],
              stops: const [0.0, 0.05, 0.95, 1.0],
            ),
            backgroundBlendMode: BlendMode.multiply,
          ),
          child: BackdropFilter(
            // Blur effect
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
