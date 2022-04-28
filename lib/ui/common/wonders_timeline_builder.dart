import 'package:flutter/foundation.dart';
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
    // TODO: Min size needs to be a pixel based number (not fraction), injected from outside. Probably need to get the constraints of this builder to do that (Layout Builder)
    return max(.01, (data.endYr - data.startYr) / totalYrs);
  }

  // ignore: unused_element
  Alignment _calculateTimelinePos(WonderData data) {
    final totalYrs = wondersLogic.endYear - wondersLogic.startYear;
    final fraction = -1 + ((data.startYr - wondersLogic.startYear) / totalYrs) * 2;
    final double x = isHz ? fraction : 0;
    final double y = isHz ? 0 : fraction;
    if (kDebugMode) {
      print('align: $y');
    }
    return Alignment(x, y);
  }

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

    return Stack(children: [
      /// We always have 3 "lanes" which we strategically distribute wonders that
      /// should not overlap
      wrapFlex([
        // Slot 1
        // _buildTimelineStack(
        //   context,
        //   [
        //     WonderType.greatWall,
        //   ],
        // ),
        // Slot 2
        _buildTimelineStack(
          context,
          [
            //WonderType.chichenItza,
            //WonderType.machuPicchu,
            WonderType.petra,
          ],
        ),
        // Slot 3
        // _buildTimelineStack(
        //   context,
        //   [
        //     WonderType.tajMahal,
        //     WonderType.christRedeemer,
        //     WonderType.colosseum,
        //   ],
        // ),
      ])
    ]);
  }

  Widget _buildTimelineStack(BuildContext context, List<WonderType> types) {
    return Stack(
      children: types.map(
        (t) {
          final data = wondersLogic.getData(t);
          // Depending on axis, we set either width, or height to a number < 1.
          double width = isHz ? _calculateTimelineSize(data) : 1;
          double height = isHz ? 1 : _calculateTimelineSize(data);
          return SizedBox.expand(
            child: FractionallySizedBox(
              widthFactor: width,
              heightFactor: height,
              child: timelineBuilder.call(context, data),
            ),
          );
        },
      ).toList(),
    );
  }
}
