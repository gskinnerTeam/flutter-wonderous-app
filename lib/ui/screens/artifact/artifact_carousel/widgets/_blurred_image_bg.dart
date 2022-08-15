part of '../artifact_carousel_screen.dart';

/// Blurry image background for the Artifact Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class _BlurredImageBg extends StatelessWidget {
  const _BlurredImageBg({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.25,
      alignment: Alignment(0, 0.8),
      child: Stack(children: [
        Positioned.fill(child: AppImage(image: url == null ? null : NetworkImage(url!), fit: BoxFit.cover)),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: $styles.colors.black.withOpacity(0.6)),
          ),
        ),
      ]),
    );
  }
}
