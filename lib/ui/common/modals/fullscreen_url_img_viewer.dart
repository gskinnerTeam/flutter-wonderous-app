import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/haptic.dart';

class FullscreenUrlImgViewer extends StatefulWidget {
  const FullscreenUrlImgViewer({Key? key, required this.urls, this.index = 0}) : super(key: key);
  final List<String> urls;
  final int index;

  @override
  State<FullscreenUrlImgViewer> createState() => _FullscreenUrlImgViewerState();
}

class _FullscreenUrlImgViewerState extends State<FullscreenUrlImgViewer> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBackPressed() => Navigator.pop(context, _controller.page!.round());

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: _isZoomed,
      builder: (_, __) {
        final bool enableSwipe = !_isZoomed.value && widget.urls.length > 1;
        return PageView.builder(
          physics: enableSwipe ? PageScrollPhysics() : NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: widget.urls.length,
          itemBuilder: (_, index) => _Viewer(widget.urls[index], _isZoomed),
          onPageChanged: (_) => Haptic.lightImpact(),
        );
      },
    );

    content = Semantics(
      label: $strings.fullscreenImageViewerSemanticFull,
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return Container(
      color: $styles.colors.greyStrong,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          BackBtn.close(onPressed: _handleBackPressed).safe(),
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
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      onInteractionEnd: (_) => widget.isZoomed.value = _controller.value.getMaxScaleOnAxis() > 1,
      minScale: 1,
      maxScale: 5,
      child: Hero(
        tag: widget.url,
        child: AppImage(
          image: NetworkImage(widget.url),
          fit: BoxFit.contain,
          scale: 2.5,
        ),
      ),
    );
  }
}
