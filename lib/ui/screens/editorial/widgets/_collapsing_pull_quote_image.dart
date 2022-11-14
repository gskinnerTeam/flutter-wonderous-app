part of '../editorial_screen.dart';

class _CollapsingPullQuoteImage extends StatelessWidget {
  const _CollapsingPullQuoteImage({Key? key, required this.scrollPos, required this.data}) : super(key: key);
  final ValueNotifier<double> scrollPos;
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    // Start transitioning when we are halfway up the screen
    final collapseStartPx = context.heightPx * 1;
    final collapseEndPx = context.heightPx * .15;
    const double imgHeight = 430;
    const double outerPadding = 100;

    /// A single piece of quote text, this widget has one on top, and one on bottom
    Widget buildText(String value, double collapseAmt, {required bool top, bool isAuthor = false}) {
      var quoteStyle = $styles.text.quote1;
      quoteStyle = quoteStyle.copyWith(color: $styles.colors.caption);
      if (isAuthor) {
        quoteStyle = quoteStyle.copyWith(fontSize: 20 * $styles.scale, fontWeight: FontWeight.w600);
      }
      double offsetY = (imgHeight / 2 + outerPadding * .25) * (1 - collapseAmt);
      if (top) offsetY *= -1; // flip?
      return Transform.translate(
          offset: Offset(0, offsetY),
          child: BlendMask(
            blendModes: const [BlendMode.colorBurn],
            child: Text(value, style: quoteStyle, textAlign: TextAlign.center),
          ));
    }

    return ValueListenableBuilder<double>(
      valueListenable: scrollPos,
      builder: (context, value, __) {
        double collapseAmt = 1.0;
        final yPos = ContextUtils.getGlobalPos(context)?.dy;
        if (yPos != null && yPos < collapseStartPx) {
          // Get a normalized value, 0 - 1, representing the current amount of collapse.
          collapseAmt = (collapseStartPx - max(collapseEndPx, yPos)) / (collapseStartPx - collapseEndPx);
        }

        // The sized boxes in the column collapse to a zero height, allowing the quotes to naturally sit over top of the image
        return MergeSemantics(
          child: CenteredBox(
            padding: EdgeInsets.symmetric(vertical: outerPadding),
            width: 450,
            child: Stack(
              children: [
                Container(
                  width: context.widthPx,
                  height: imgHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: $styles.colors.accent2),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(context.widthPx / 2),
                      topLeft: Radius.circular(context.widthPx / 2),
                    ),
                  ),
                ),

                /// Main image
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: imgHeight,

                      // Clip the image with an curved top
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.all(12),
                            child: ClipPath(
                              clipper: CurvedTopClipper(),
                              child: _buildImage(collapseAmt),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Collapsing text
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: StaticTextScale(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 32), // push down vertical centre
                          buildText(data.pullQuote1Top, collapseAmt, top: true),
                          buildText(data.pullQuote1Bottom, collapseAmt, top: false),
                          if (data.pullQuote1Author.isNotEmpty) ...[
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: buildText('- ${data.pullQuote1Author}', collapseAmt, top: false, isAuthor: true),
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(double collapseAmt) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ScalingListItem(
          scrollPos: scrollPos,
          child: Image.asset(
            data.type.photo2,
            fit: BoxFit.cover,
            opacity: AlwaysStoppedAnimation(1 - collapseAmt * .7),
          ),
        ),
        GradientContainer(
          [
            Color(0xFFBEABA1).withOpacity(1),
            Color(0xFFA6958C).withOpacity(1),
          ],
          const [0.0, 1.0],
          blendMode: BlendMode.colorBurn,
        ),
      ],
    );
  }
}
