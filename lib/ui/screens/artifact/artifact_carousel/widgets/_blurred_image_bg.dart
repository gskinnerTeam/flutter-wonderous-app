part of '../artifact_carousel_screen.dart';

/// Blurry image background for the Artifact Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class _BlurredImageBg extends StatelessWidget {
  const _BlurredImageBg({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    final img = AppImage(
      image: url == null ? null : NetworkImage(url!),
      syncDuration: $styles.times.fast,
      fit: BoxFit.cover,
      scale: 0.5,
    );
    final fgOpacity = settingsLogic.useBlurs ? 0.6 : 0.8;
    return Transform.scale(
      scale: 1.25,
      alignment: Alignment(0, 0.8),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: $styles.colors.black.withOpacity(fgOpacity),
        ),
        child: settingsLogic.useBlurs
            ? ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: img,
              )
            : img,
      ),
    );
  }
}
