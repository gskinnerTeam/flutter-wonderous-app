import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class WondersTimelineBuilder extends StatelessWidget {
  const WondersTimelineBuilder({
    Key? key,
    this.selectedWonders = const [],
    required this.timelineBuilder,
    this.axis = Axis.horizontal,
    this.crossAxisGap,
  }) : super(key: key);
  final List<WonderType> selectedWonders;
  final Widget Function(BuildContext, WonderData type) timelineBuilder;
  final Axis axis;
  final double? crossAxisGap;
  bool get isHz => axis == Axis.horizontal;

  double _calculateTimelineSize(WonderData data) {
    final totalYrs = wondersLogic.endYear - wondersLogic.startYear;
    return max(.04, (data.endYr - data.startYr) / totalYrs);
  }

  Alignment _calculateTimelinePos(WonderData data) {
    final totalYrs = wondersLogic.endYear - wondersLogic.startYear;
    final fraction = -1 + ((data.startYr - wondersLogic.startYear) / totalYrs) * 2;
    final double x = isHz ? fraction : 0;
    final double y = isHz ? 0 : fraction;
    return Alignment(x, y);
  }

  /// TODO: Different wonders need to go in different lanes
  @override
  Widget build(BuildContext context) {
    Widget buildTimeline(WonderData data) {
      // Depending on axis, we set either width, or height to a number < 1.
      double width = isHz ? _calculateTimelineSize(data) : 1;
      double height = isHz ? 1 : _calculateTimelineSize(data);
      return Expanded(
        child: SizedBox.expand(
          child: Align(
            alignment: _calculateTimelinePos(data),
            child: FractionallySizedBox(
              widthFactor: width,
              heightFactor: height,
              child: timelineBuilder.call(context, data),
            ),
          ),
        ),
      );
    }

    final wonders = wondersLogic.all;
    final gap = crossAxisGap ?? context.insets.xs;
    // Depending on axis, we put all the wonders in a hz row, or a vertical column
    Widget wrapFlex(List<Widget> c) => isHz
        ? SeparatedColumn(separatorBuilder: () => Gap(gap), children: c)
        : SeparatedRow(separatorBuilder: () => Gap(gap), children: c);

    return Stack(children: [
      wrapFlex([...wonders.map(buildTimeline)])
    ]);
  }
}
