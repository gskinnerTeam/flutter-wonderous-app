part of '../artifact_details_screen.dart';

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    void _handleImagePressed() async {
      await Navigator.push(
        context,
        PageRoutes.fadeThrough(FullscreenUrlImgViewer(url: data.image)),
      );
    }

    return Stack(
      children: [
        BottomCenter(
          child: FractionalTranslation(
            translation: Offset(0, 0.99),
            child: VtGradient(
              [context.colors.greyStrong, context.colors.greyStrong.withOpacity(0)],
              const [.2, 1],
              height: context.insets.lg,
            ),
          ),
        ),
        Container(
          color: context.colors.greyStrong,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: _handleImagePressed,
            child: Hero(
              tag: data.image,
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                placeholder: (BuildContext context, String url) => const AppLoader(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
