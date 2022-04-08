part of '../editorial_screen.dart';

class _SlidingImageStack extends StatelessWidget {
  final ValueNotifier<double> scrollPos;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    final size = Size(280, 360);
    Container _buildPhoto(double scale, String url, Alignment align, {bool top = true}) {
      return Container(
        width: size.width * scale,
        height: size.height * scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(top ? size.width / 2 : 0),
            bottom: Radius.circular(top ? 0 : size.width / 2),
          ),
          image: DecorationImage(image: AssetImage(url), fit: BoxFit.fitWidth, alignment: align),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: ValueListenableBuilder(
          valueListenable: scrollPos,
          builder: (BuildContext context, double value, Widget? child) {
            double pctVisible = 0;
            final yPos = ContextUtils.getGlobalPos(context)?.dy;
            final height = ContextUtils.getSize(context)?.height;
            if (yPos != null && height != null) {
              final amtVisible = context.heightPx - yPos;
              pctVisible = (amtVisible / height).clamp(0, 3);
            }
            return Stack(
              children: [
                TopRight(
                  child: FractionalTranslation(
                    translation: Offset(0, .1 * pctVisible),
                    child: _buildPhoto(
                      .73,
                      type.photo3,
                      Alignment(0, -.3 + .6 * pctVisible),
                    ),
                  ),
                ),
                BottomLeft(
                  child: _buildPhoto(
                    .45,
                    type.photo4,
                    Alignment(0, .3 - .6 * pctVisible),
                    top: false,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  const _SlidingImageStack({Key? key, required this.scrollPos, required this.type}) : super(key: key);
}
