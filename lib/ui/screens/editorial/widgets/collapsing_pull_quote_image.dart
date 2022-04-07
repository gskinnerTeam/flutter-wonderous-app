part of '../editorial_screen.dart';

class CollapsingPullQuoteImage extends StatelessWidget {
  const CollapsingPullQuoteImage({Key? key, required this.scrollPos, required this.data}) : super(key: key);
  final ValueNotifier<double> scrollPos;
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    // Start transitioning when we are halfway up the screen
    final collapseStartPx = context.heightPx * .75;
    final collapseEndPx = context.heightPx * .25;
    const double imgHeight = 450;
    const outerPadding = 150;
    double collapseAmt = 0;

    /// A single piece of quote text, this widget has one on top, and one on bottom
    Widget buildText(String value, {required bool top}) {
      final quoteStyle = context.textStyles.quote.copyWith(fontSize: 42, color: Color(0xFF888888).withOpacity(1));
      return Transform.translate(
          offset: Offset(0, (imgHeight / 2 + outerPadding * .25) * (1 - collapseAmt) * (top ? -1 : 1)),
          child: BlendMask(
            blendModes: const [BlendMode.colorBurn],
            child: Text(value.toUpperCase(), style: quoteStyle, textAlign: TextAlign.center),
          ));
    }

    return ValueListenableBuilder<double>(
      valueListenable: scrollPos,
      builder: (context, value, __) {
        final yPos = ContextUtils.getGlobalPos(context)?.dy;
        if (yPos != null && yPos < collapseStartPx) {
          // Get a normalized value, 0 - 1, representing the current amount of collapse.
          collapseAmt = (collapseStartPx - max(collapseEndPx, yPos)) / (collapseStartPx - collapseEndPx);
        }
        // The sized boxes in the column collapse to a zero height, allowing the quotes to naturally sit over top of the image
        return Padding(
          padding: EdgeInsets.symmetric(vertical: outerPadding * (1 - collapseAmt)),
          child: Stack(
            children: [
              /// Main image
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.insets.md),
                child: SizedBox(
                  height: imgHeight,
                  width: 290,
                  // Clip the image with an curved top
                  child: ClipPath(
                    clipper: CurvedTopClipper(),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        GreyScale(
                          child: ScalingListItem(
                            scrollPos: scrollPos,
                            child: Image.asset(data.type.photo2, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned.fill(child: ColoredBox(color: Colors.black.withOpacity(.3)))
                      ],
                    ),
                  ),
                ),
              ),

              /// Collapsing text
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildText(data.quote1, top: true),
                    Gap(context.insets.sm),
                    buildText(data.quote2, top: false),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
