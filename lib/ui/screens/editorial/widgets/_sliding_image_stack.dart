part of '../editorial_screen.dart';

class _SlidingImageStack extends StatelessWidget {
  const _SlidingImageStack({Key? key, required this.scrollPos, required this.type}) : super(key: key);

  final ValueNotifier<double> scrollPos;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    final totalSize = Size(280, 400);
    Container buildPhoto(double scale, String url, Alignment align, {bool top = true}) {
      return Container(
        width: totalSize.width * scale,
        height: totalSize.height * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(top ? totalSize.width / 2 : 0),
            bottom: Radius.circular(top ? 0 : totalSize.width / 2),
          ),
          image: DecorationImage(image: AssetImage(url), fit: BoxFit.fitWidth, alignment: align),
        ),
      );
    }

    return ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: totalSize.width,
          height: totalSize.height,
          child: ValueListenableBuilder(
            valueListenable: scrollPos,
            builder: (context, value, child) {
              double pctVisible = 0;
              final yPos = ContextUtils.getGlobalPos(context)?.dy;
              final height = ContextUtils.getSize(context)?.height;
              if (yPos != null && height != null) {
                final amtVisible = context.heightPx - yPos;
                pctVisible = (amtVisible / height).clamp(0, 3);
              }
              return Stack(
                children: [
                  Center(
                    child: FractionalTranslation(
                      translation: Offset(0, 0.05 * pctVisible),
                      child: Transform(
                        alignment: Alignment.center, //origin: Offset(100, 100)
                        transform: Matrix4.rotationZ(0.9),
                        child: Container(
                          width: context.widthPx / 1.75,
                          height: context.widthPx,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.elliptical(200, 300)),
                            border: Border.all(
                              color: $styles.colors.accent2,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TopRight(
                    child: FractionalTranslation(
                      translation: Offset(0, -.1 + .2 * pctVisible),
                      child: buildPhoto(
                        .73,
                        type.photo3,
                        Alignment(0, -.3 + .6 * pctVisible),
                      ),
                    ),
                  ),
                  BottomLeft(
                    child: FractionalTranslation(
                      translation: Offset(0, -.14 * pctVisible),
                      child: buildPhoto(
                        .45,
                        type.photo4,
                        Alignment(0, .3 - .6 * pctVisible),
                        top: false,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
