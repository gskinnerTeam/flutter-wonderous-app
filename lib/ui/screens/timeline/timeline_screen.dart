import 'dart:ui';

import 'package:wonders/common_libs.dart';

part 'widgets/_bottom_scrubber.dart';
part 'widgets/_scaling_viewport.dart';
part 'widgets/_events_overlay.dart';
part 'widgets/_year_markers.dart';

class TimelineScreen extends StatefulWidget {
  final WonderType type;

  const TimelineScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late final ScrollController _scroller = ScrollController()..addListener(_handleScroll);
  final _viewportKey = GlobalKey<ScalingViewportState>();
  // todo: this + the slider that uses it, is just for testing, remove once timeline is completed
  double _zoomOverride = 1;

  void _handleScroll() {
    print(_scroller.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // Determine min and max size of the timeline based on the size available to this widget
      const scrubberSize = 150.0;
      final double minSize = constraints.biggest.height - scrubberSize;
      const double maxSize = 3000;
      return SafeArea(
        child: Column(
          children: [
            /// Vertically scrolling timeline, manages a ScrollController.
            Expanded(
              child: Stack(
                children: [
                  /// Event popups that appear when you scroll
                  _EventsOverlay(),

                  /// The timeline content itself
                  _ScalingViewport(
                    key: _viewportKey,
                    controller: _scroller,
                    minSize: minSize,
                    maxSize: maxSize,
                    startYr: -500,
                    endYr: 2000,
                  ),
                ],
              ),
            ),

            /// Mini Horizontal timeline, reacts to the state of the timeline,
            /// and drives it's scroll position on Hz drag
            _BottomScrubber(_scroller, size: scrubberSize, timelineMinSize: minSize),

            // TODO: remove this slider when Timeline is complete
            Slider(
              value: _zoomOverride,
              //TODO: Somehow this needs to rebuild BottomScrubber on zoom, scrollerController doesn't dispatch changes when child content changes
              // We want to pass something more than a scrollController here... maybe the ViewportState itself? Or a data construct that represents ViewportState?
              // Or, we could make a top-down controller, and make Viewport dumb, and pass the controller to both scrubber and viewport.
              // We could also just KISS and pass in the current zoom value as a key to bottom scrubber??
              onChanged: (double value) {
                _zoomOverride = value;
                _viewportKey.currentState?.setZoom(_zoomOverride);
                setState(() {});
              },
            ),
          ],
        ),
      );
    });
  }
}
