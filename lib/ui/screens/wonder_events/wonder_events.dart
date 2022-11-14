import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_backdrop.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/curved_clippers.dart';
import 'package:wonders/ui/common/hidden_collectible.dart';
import 'package:wonders/ui/common/list_gradient.dart';
import 'package:wonders/ui/common/pop_router_on_over_scroll.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/timeline_event_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part 'widgets/_events_list.dart';
part 'widgets/_timeline_btn.dart';
part 'widgets/_wonder_image_with_timeline.dart';

class WonderEvents extends StatelessWidget {
  WonderEvents({Key? key, required this.type}) : super(key: key);
  final WonderType type;
  late final _data = wondersLogic.getData(type);

  @override
  Widget build(BuildContext context) {
    void handleTimelineBtnPressed() => context.push(ScreenPaths.timeline(type));
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: $styles.colors.black,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                top: $styles.insets.lg,
                child: context.isLandscape ? _buildLandscape() : _buildPortrait(),
              ),
              Positioned(
                  right: $styles.insets.lg,
                  top: $styles.insets.lg,
                  child: CircleIconBtn(
                      icon: AppIcons.timeline,
                      onPressed: handleTimelineBtnPressed,
                      semanticLabel: $strings.eventsListButtonOpenGlobal)),
            ],
          ),
        ),
      );
    });
  }

  /// Landscape layout is a row, with the WonderImage on left and events on the right
  Widget _buildLandscape() {
    return Row(
      children: [
        /// WonderImage w/ Timeline btn sits on the left
        Expanded(
          child: Center(
            child: SizedBox(
              width: $styles.sizes.maxContentWidth3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap($styles.insets.lg),
                  Expanded(child: Center(child: _WonderImageWithTimeline(data: _data, height: 500))),
                  Gap($styles.insets.lg),
                  SizedBox(width: 300, child: _TimelineBtn(type: type)),
                  Gap($styles.insets.xl),
                ],
              ),
            ),
          ),
        ),

        /// Scrolling event list
        Expanded(
          child: Center(
            child: SizedBox(
              width: $styles.sizes.maxContentWidth1,
              child: _EventsList(data: _data, topHeight: 100, blurOnScroll: false),
            ),
          ),
        ),
      ],
    );
  }

  /// Portrait layout is a stack with the list scrolling overtop of the WonderImage
  Widget _buildPortrait() {
    return LayoutBuilder(builder: (_, constraints) {
      double topHeight = max(constraints.maxHeight * .55, 200);
      return Center(
        child: SizedBox(
          width: $styles.sizes.maxContentWidth3,
          child: Stack(
            children: [
              /// Top content, sits underneath scrolling list
              _WonderImageWithTimeline(height: topHeight, data: _data),

              /// Scrolling Events list, takes up the full view
              Column(
                children: [
                  Expanded(
                    child: _EventsList(data: _data, topHeight: topHeight, blurOnScroll: true, showTopGradient: false),
                  ),
                  Gap($styles.insets.lg),
                  SizedBox(width: $styles.sizes.maxContentWidth3, child: _TimelineBtn(type: _data.type)),
                  Gap($styles.insets.xl),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
