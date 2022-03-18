import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class TimelineScreen extends StatefulWidget {
  final WonderType type;

  const TimelineScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Vertically scrolling timeline, manages a ScrollController.
        Expanded(
          child: WondersTimeline(controller: _scroller),
        ),

        /// Mini Horizontal timeline
        _TimelineScrubber(_scroller),
      ],
    );
  }
}

class TimelineController extends ChangeNotifier {}

class WondersTimeline extends StatefulWidget {
  const WondersTimeline({Key? key, this.controller}) : super(key: key);
  final ScrollController? controller;
  @override
  State<WondersTimeline> createState() => _WondersTimelineState();
}

class _WondersTimelineState extends State<WondersTimeline> {
  late final ScrollController _controller = ScrollController();

  double _zoom = .5;
  double _minSize = 500;
  double _maxSize = 2000;

  ScrollController get controller => widget.controller ?? ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _handleScroll() {
  //   // print(controller.offset);
  //   // print(controller.position.maxScrollExtent);
  // }
  //
  void _changeScale(double d) {
    setState(() {
      _zoom = d;
      _zoom = _zoom.clamp(0, 1.0);
    });
  }

  //
  // void _handleMouseZoom(e) {
  //   if (e is PointerScrollEvent) {
  //     final scaleDelta = .05 * (e.scrollDelta.dy > 0 ? -1 : 1);
  //     _changeScale(scaleDelta);
  //     //print(scaleDelta);
  //     // fix position
  //     final moveDelta = (_maxSize - _minSize) * scaleDelta;
  //     //_scroller.position.jumpTo(max(_scroller.position.pixels + moveDelta / 2, 0));
  //   }
  // }

  void _handlePinchZoom(ScaleUpdateDetails details) {
    _changeScale(details.scale);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _minSize = constraints.biggest.height;
      _maxSize = constraints.biggest.height * 3;
      double size = lerpDouble(_minSize, _maxSize, _zoom) ?? _maxSize;

      return GestureDetector(
        onScaleUpdate: _handlePinchZoom,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              physics: ClampingScrollPhysics(),
              child: Placeholder(fallbackHeight: size),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(context.insets.xl * 2),
                child: SizedBox(
                  height: max(60, context.heightPct(.1)),
                  child: Slider(
                    onChanged: (double value) => setState(() {
                      _zoom = value;
                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                      controller.notifyListeners();
                    }),
                    value: _zoom,
                    min: 0,
                    max: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _TimelineScrubber extends StatelessWidget {
  const _TimelineScrubber(this.scroller, {Key? key}) : super(key: key);
  final ScrollController scroller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Placeholder(fallbackHeight: 200),
        AnimatedBuilder(
          animation: scroller,
          builder: (_, __) {
            double scrollOffset = 0;
            double viewPort = 1;
            if (scroller.hasClients) {
              if (scroller.position.maxScrollExtent > 0) {
                scrollOffset = scroller.position.pixels / scroller.position.maxScrollExtent;
              }
              // print(scroller.position.maxScrollExtent);
              final viewportSize = scroller.position.viewportDimension;
              viewPort = viewportSize / (scroller.position.maxScrollExtent + viewportSize);
              viewPort = viewPort.clamp(0, 1);
              //print(viewPort);
            }
            return Positioned.fill(
              child: Align(
                alignment: Alignment(-1 + scrollOffset * 2, 0),
                child: FractionallySizedBox(
                  child: ColoredBox(color: Colors.red.withOpacity(.3)),
                  widthFactor: viewPort,
                  heightFactor: 1,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
