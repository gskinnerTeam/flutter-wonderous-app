import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/utils/haptic.dart';

class FullscreenUrlImgViewer extends StatefulWidget {
  const FullscreenUrlImgViewer({Key? key, required this.urls, this.index = 0, this.onClose}) : super(key: key);
  final List<String> urls;
  final int index;
  final Function(int)? onClose;

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final ValueNotifier<bool> isZoomed = ValueNotifier(false);
  late final PageController controller = PageController(initialPage: widget.index);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: isZoomed,
      builder: (_, __) {
        final bool enableSwipe = !isZoomed.value && widget.urls.length > 1;
        return PageView.builder(
          physics: enableSwipe ? PageScrollPhysics() : NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: widget.urls.length,
          itemBuilder: (_, index) => _Viewer(widget.urls[index], isZoomed),
          onPageChanged: (_) => Haptic.lightImpact(),
        );
      },
    );

    content = Semantics(
      label: 'full screen image, no description available', // TODO: translate.
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return Container(
      color: $styles.colors.greyStrong,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          BackBtn.close(
            onPressed: () {
              widget.onClose?.call(controller.page!.round());
              Navigator.pop(context);
            }
          ).safe(),
        ],
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer(this.url, this.isZoomed, {Key? key}) : super(key: key);

  final String url;
  final ValueNotifier<bool> isZoomed;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> {
  final TransformationController controller = TransformationController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: controller,
      onInteractionEnd: (_) => widget.isZoomed.value = controller.value.getMaxScaleOnAxis() > 1,
      minScale: 1,
      maxScale: 5,
      child: Hero(
        tag: widget.url,
        child: ImageFade(
          syncDuration: 0.ms,
          image: NetworkImage(widget.url),
          fit: BoxFit.contain,
          loadingBuilder: (_, __, ___) => const Center(child: AppLoader()),
        ),
      ),
    );
  }
}
