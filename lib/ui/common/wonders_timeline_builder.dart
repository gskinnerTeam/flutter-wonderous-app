import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

/// Visualizes all of the wonders over time.
/// Distributes the wonders over multiple "tracks" so that
/// they do not overlap. Provides a builder, so the visual representation
/// of each "track item" can be customized.
///
class WondersTimelineBuilder extends StatelessWidget {
  const WondersTimelineBuilder({
    Key? key,
    this.selectedWonders = const [],
    required this.timelineBuilder,
    this.axis = Axis.horizontal,
    this.crossAxisGap,
    this.minSize = 10,
  }) : super(key: key);
  final List<WonderType> selectedWonders;
  // Todo: Builder should be optional, and build simple version by default
  final Widget Function(BuildContext, WonderData type) timelineBuilder;
  final Axis axis;
  final double? crossAxisGap;
  final double minSize;
  bool get isHz => axis == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    final gap = crossAxisGap ?? context.insets.xs;
    // Depending on axis, we put all the wonders in a hz row, or vt column
    Widget wrapFlex(List<Widget> c) {
      c = c.map<Widget>((w) => Expanded(child: w)).toList();
      return isHz
          ? SeparatedColumn(verticalDirection: VerticalDirection.up, separatorBuilder: () => Gap(gap), children: c)
          : SeparatedRow(separatorBuilder: () => Gap(gap), children: c);
    }

    return LayoutBuilder(builder: (_, constraints) {
      /// Builds one timeline track, may contain multiple wonders, but they should not overlap
      Widget buildSingleTimelineTrack(BuildContext context, List<WonderType> types) {
        return Stack(
          children: types.map(
            (t) {
              final data = wondersLogic.getData(t);
              // Total number of yrs this wonder spans
              int wonderYrs = data.endYr - data.startYr;
              // How many yrs away from the global start yr is this wonder (this will become top padding)
              int yrsFromStart = data.startYr - wondersLogic.startYear;
              // What is the total global time span
              int totalYrs = wondersLogic.endYear - wondersLogic.startYear;
              // Figure out the ratio of pixels : years for this view, this will allow us to convert years, to pixel based positions.
              double pxToYrRatio = totalYrs / ((isHz ? constraints.maxWidth : constraints.maxHeight));
              // Using pxRatio, figure out how big this wonder should be
              double pxSize = max(wonderYrs / pxToYrRatio, minSize);
              // What is the middle yr for this wonder, we want to position each wonder at it's center-point
              double centerYr = yrsFromStart + wonderYrs / 2;
              // Find the px offset that represents the center year
              double pxOffset = centerYr / pxToYrRatio;

              // Using the above calculations, we can position the widget we need.
              // Looks more complicated than it is here as we're supporting both vertical and horizontal layout in a single pass.
              final align = isHz ? Alignment.centerLeft : Alignment.topCenter;
              final startPadding =
                  isHz ? EdgeInsets.only(top: 0, left: pxOffset) : EdgeInsets.only(top: pxOffset, left: 0);
              final parentSize = Size(isHz ? 0 : constraints.maxWidth, isHz ? constraints.maxHeight : 0);
              final childSize = Size(isHz ? pxSize : 0, isHz ? 0 : pxSize);

              return SizedBox.expand(
                child: Container(
                  alignment: align,
                  padding: startPadding,
                  // SizedBox, aligned to the center yr for this wonder. Either width or height will be 0 for this.
                  child: SizedBox(
                    width: parentSize.width,
                    height: parentSize.height,
                    // An overflow box allows the timelineBuilder to build as big as we want it
                    child: OverflowBox(
                      maxWidth: double.infinity,
                      maxHeight: double.infinity,
                      // Set width/height to the expected pxSize of the wonder, which will respect min-size settings
                      child: SizedBox(
                        height: childSize.height,
                        width: childSize.width,
                        child: timelineBuilder.call(context, data),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      }

      return Stack(children: [
        wrapFlex([
          // Track 1
          buildSingleTimelineTrack(
            context,
            [
              WonderType.greatWall,
              WonderType.pyramidsGiza,
              WonderType.christRedeemer,
            ],
          ),
          // Track 2
          buildSingleTimelineTrack(
            context,
            [
              WonderType.chichenItza,
              WonderType.machuPicchu,
              WonderType.petra,
            ],
          ),
          // Track 3
          buildSingleTimelineTrack(
            context,
            [
              WonderType.tajMahal,
              WonderType.colosseum,
            ],
          ),
        ])
      ]);
    });
  }
}
