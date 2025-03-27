part of '../wonder_events.dart';

class _WonderImageWithTimeline extends StatelessWidget {
  const _WonderImageWithTimeline({super.key, required this.data, required this.height});
  final WonderData data;
  final double height;

  Color _fixLuminance(Color color, [double luminance = 0.2]) {
    double d = luminance - color.computeLuminance();
    if (d <= 0) return color;
    int r = color.red, g = color.green, b = color.blue;
    return Color.fromARGB(255, (r + (255 - r) * d).toInt(), (g + (255 - g) * d).toInt(), (b + (255 - b) * d).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: MergeSemantics(
        child: LightText(
          child: SeparatedColumn(
            separatorBuilder: () => Gap($styles.insets.xs * 1.5),
            padding: EdgeInsets.only(bottom: $styles.insets.sm),
            children: [
              /// Text and image in a stack
              Expanded(
                child: Stack(children: [
                  /// Image with fade on btm
                  Center(
                    child: _buildImageWithFade(context),
                  ),

                  /// Title text
                  BottomCenter(
                    child: WonderTitleText(data, enableHero: false),
                  )
                ]),
              ),

              /// Bottom timeline
              ExcludeSemantics(
                child: SizedBox(
                  height: 50,
                  child: WondersTimelineBuilder(
                      selectedWonders: [data.type],
                      timelineBuilder: (_, data, isSelected) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? _fixLuminance(data.type.fgColor) : Colors.transparent,
                            border: isSelected
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: $styles.colors.greyMedium),
                            borderRadius: BorderRadius.circular($styles.corners.md),
                          ),
                        );
                      }),
                ),
              ),
              _buildEraTextRow(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithFade(BuildContext context) {
    return ExcludeSemantics(
      child: Stack(
        children: [
          /// Image
          ClipPath(
            clipper: CurvedTopClipper(),
            child: Image.asset(
              data.type.flattened,
              excludeFromSemantics: true,
              width: 200,
              fit: BoxFit.cover,
              alignment: Alignment(0, -.5),
            ),
          ),

          /// Vertical gradient on btm
          Positioned.fill(
            child: BottomCenter(
              child: ListOverscollGradient(bottomUp: true, size: 200),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEraTextRow(BuildContext context) {
    final textStyle = $styles.text.body.copyWith(color: $styles.colors.accent2, height: 1);
    return SeparatedRow(
      separatorBuilder: () => Gap($styles.insets.sm),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          $strings.titleLabelDate(
            StringUtils.formatYr(data.startYr),
            StringUtils.formatYr(data.endYr),
          ),
          style: textStyle,
        ),
        _buildDot(context),
        Text(StringUtils.getEra(data.startYr), style: textStyle),
      ],
    ).maybeAnimate().fade(delay: $styles.times.pageTransition);
  }

  Widget _buildDot(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(color: $styles.colors.accent2, borderRadius: BorderRadius.circular(99)),
    );
  }
}
