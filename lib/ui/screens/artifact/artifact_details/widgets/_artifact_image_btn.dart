part of '../artifact_details_screen.dart';

class _ArtifactImageBtn extends StatelessWidget {
  const _ArtifactImageBtn({super.key, required this.data});
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomCenter(
          child: Transform.translate(
            offset: Offset(0, $styles.insets.xl - 1),
            child: VtGradient(
              [$styles.colors.greyStrong, $styles.colors.greyStrong.withOpacity(0)],
              const [0, 1],
              height: $styles.insets.xl,
            ),
          ),
        ),
        Container(
          color: $styles.colors.black,
          alignment: Alignment.center,
          child: AppBtn.basic(
            semanticLabel: $strings.artifactDetailsSemanticThumbnail,
            onPressed: () => _handleImagePressed(context),
            child: SafeArea(
              bottom: false,
              minimum: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Hero(
                tag: data.selfHostedImageUrl,
                child: AppImage(
                  image: NetworkImage(data.selfHostedImageUrl),
                  fit: BoxFit.contain,
                  distractor: true,
                  scale: FullscreenUrlImgViewer.imageScale, // so the image isn't reloaded
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleImagePressed(BuildContext context) {
    appLogic.showFullscreenDialogRoute(context, FullscreenUrlImgViewer(urls: [data.selfHostedImageUrl]));
  }
}
