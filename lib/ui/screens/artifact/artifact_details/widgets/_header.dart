part of '../artifact_details_screen.dart';

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomCenter(
          child: Transform.translate(
            offset: Offset(0, context.insets.xl - 1),
            child: VtGradient(
              [context.colors.greyStrong, context.colors.greyStrong.withOpacity(0)],
              const [0, 1],
              height: context.insets.xl,
            ),
          ),
        ),
        Container(
          color: context.colors.black,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () => _handleImagePressed(context),
            child: SafeArea(
              bottom: false,
              minimum: EdgeInsets.symmetric(vertical: context.insets.sm),
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                placeholder: (context, url) => const AppLoader(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleImagePressed(BuildContext context) {
    Navigator.push(context, PageRoutes.fadeThrough(FullscreenUrlImgViewer(url: data.image)));
  }
}
