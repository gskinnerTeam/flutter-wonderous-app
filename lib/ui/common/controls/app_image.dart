import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loading_indicator.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.image,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.duration,
    this.distractor = false,
    this.progress = false,
    this.color,
    this.scale,
  }) : super(key: key);

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image: capImageSize(image, context),
      fit: fit,
      alignment: alignment,
      duration: duration ?? $styles.times.fast,
      syncDuration: 0.ms,
      loadingBuilder: (_, value, ___) {
        if (!distractor && !progress) return SizedBox();
        return Center(child: AppLoadingIndicator(value: progress ? value : null, color: color));
      },
      errorBuilder: (_, __) => Container(
        padding: EdgeInsets.all($styles.insets.xs),
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (_, constraints) {
          double size = min(constraints.biggest.width, constraints.biggest.height);
          if (size < 16) return SizedBox();
          return Icon(
            Icons.image_not_supported_outlined,
            color: $styles.colors.white.withOpacity(0.1),
            size: min(size, $styles.insets.lg),
          );
        }),
      ),
    );
  }

  ImageProvider? capImageSize(ImageProvider? image, BuildContext context) {
    if (image == null || scale == null) return image;
    final MediaQueryData mq = MediaQuery.of(context);
    final Size screenSize = mq.size * mq.devicePixelRatio * scale!;
    return ResizeImage(image, width: screenSize.width.round());
  }
}
