import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';

/// An image that opens into a full-screen interactive viewer
//TODO: This should take an ImageData, or a url, or maybe an unsplash id??
class OpeningGridImage extends StatelessWidget {
  const OpeningGridImage(this.size, {Key? key, required this.selected}) : super(key: key);
  final bool selected;
  final Size size;

  @override
  Widget build(BuildContext context) {
    String mockImg(int size, {int quality = 95}) =>
        'https://images.unsplash.com/photo-1595450653862-394dfc73053d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=$size&q=$quality';
    return OpenContainer(
      tappable: selected,
      transitionDuration: context.times.med,
      middleColor: Colors.black,
      closedColor: Colors.black,
      openColor: Colors.black,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (_, __) => SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRect(
                /// Scale image when selected
                child: TweenAnimationBuilder<double>(
                  duration: context.times.slow,
                  curve: Curves.easeOut,
                  tween: Tween(begin: 1, end: selected ? 1.15 : 1),
                  builder: (_, value, child) => Transform.scale(child: child, scale: value),
                  child: CachedNetworkImage(
                      imageUrl: mockImg((size.width * 1.5).round()),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high),
                ),
              ),
            ),
          ],
        ),
      ),
      openBuilder: (BuildContext context, void Function({Object? returnValue}) closeAction) {
        return GestureDetector(
          onTap: closeAction,
          child: ColoredBox(
            color: Colors.black,
            child: InteractiveViewer(
              child: Image.network(mockImg((context.widthPx).round()), fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }
}
