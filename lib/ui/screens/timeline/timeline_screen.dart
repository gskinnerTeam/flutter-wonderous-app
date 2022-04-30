import 'dart:ui';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/dashed_line.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/list_gradient.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';

part 'widgets/_bottom_scrubber.dart';
part 'widgets/_scrolling_viewport.dart';
part 'widgets/_scrolling_viewport_controller.dart';
part 'widgets/_dashed_divider_with_year.dart';
part 'widgets/_year_markers.dart';
part 'widgets/_timeline_section.dart';

class TimelineScreen extends StatefulWidget {
  final WonderType type;

  const TimelineScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  // TODO: this + the slider that uses it, is just for testing, remove once timeline is completed
  double _zoomOverride = 1;

  /// Create a scroll controller that the top and bottom timelines can share
  final ScrollController _scroller = ScrollController();
  _ScrollingViewportController? _viewport;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // Determine min and max size of the timeline based on the size available to this widget
      const double scrubberSize = 80;
      final double minSize = max(500, constraints.biggest.height - scrubberSize);
      const double maxSize = 3000;
      return Container(
        color: context.colors.greyStrong,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: context.mq.viewPadding.bottom),
            child: Column(
              children: [
                /// Vertically scrolling timeline, manages a ScrollController.
                Expanded(
                  child: Stack(
                    children: [
                      /// The timeline content itself
                      _ScrollingViewport(
                        onInit: (v) => _viewport = v,
                        scroller: _scroller,
                        minSize: minSize,
                        maxSize: maxSize,
                        selectedWonder: widget.type,
                      ),
                    ],
                  ),
                ),

                /// Mini Horizontal timeline, reacts to the state of the larger scrolling timeline,
                /// and changes the timelines scroll position on Hz drag
                _BottomScrubber(
                  _scroller,
                  size: scrubberSize,
                  timelineMinSize: minSize,
                  wonderType: widget.type,
                ),

                // TODO: remove this slider when Timeline is complete
                // Slider(
                //   value: _zoomOverride,
                //   onChanged: (value) {
                //     _zoomOverride = value;
                //     _viewport?.setZoom(_zoomOverride);
                //     setState(() {});
                //   },
                // ),
                Gap(30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
