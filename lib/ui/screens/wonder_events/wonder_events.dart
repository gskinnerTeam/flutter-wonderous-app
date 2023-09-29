import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_backdrop.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/centered_box.dart';
import 'package:wonders/ui/common/controls/app_header.dart';
import 'package:wonders/ui/common/curved_clippers.dart';
import 'package:wonders/ui/common/hidden_collectible.dart';
import 'package:wonders/ui/common/list_gradient.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/timeline_event_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part 'widgets/_events_list.dart';
part 'widgets/_timeline_btn.dart';
part 'widgets/_wonder_image_with_timeline.dart';

//TODO: Maintain scroll position when switching from portrait to landscape
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
              /// Main view switches between portrait and landscape views
              Positioned.fill(
                top: $styles.insets.lg,
                child: context.isLandscape ? _buildLandscape(context) : _buildPortrait(),
              ),

              /// Header w/ TimelineBtn
              TopCenter(
                child: AppHeader(
                  showBackBtn: false,
                  isTransparent: true,
                  trailing: (_) => CircleIconBtn(
                      icon: AppIcons.timeline,
                      onPressed: handleTimelineBtnPressed,
                      semanticLabel: $strings.eventsListButtonOpenGlobal),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Landscape layout is a row, with the WonderImage on left and EventsList on the right
  Widget _buildLandscape(BuildContext context) {
    return Row(
      children: [
        /// WonderImage w/ Timeline btn
        Expanded(
          child: CenteredBox(
            width: $styles.sizes.maxContentWidth3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap($styles.insets.lg),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _WonderImageWithTimeline(data: _data, height: min(500, context.heightPx - 300)),
                        Gap($styles.insets.lg),
                        SizedBox(width: 400, child: _TimelineBtn(type: type)),
                      ],
                    ),
                  ),
                ),
                Gap($styles.insets.lg),
              ],
            ),
          ),
        ),

        /// EventsList
        Expanded(
          child: CenteredBox(
            width: $styles.sizes.maxContentWidth2,
            child: _EventsList(
              data: _data,
              topHeight: 100,
              blurOnScroll: false,
            ),
          ),
        ),
      ],
    );
  }

  /// Portrait layout is a stack with the EventsList scrolling overtop of the WonderImage
  Widget _buildPortrait() {
    return LayoutBuilder(builder: (_, constraints) {
      double topHeight = max(constraints.maxHeight * .55, 200);
      return CenteredBox(
        width: $styles.sizes.maxContentWidth3,
        child: Stack(
          children: [
            /// Top content, sits underneath scrolling list
            _WonderImageWithTimeline(height: topHeight, data: _data),

            /// EventsList + TimelineBtn
            Column(
              children: [
                Expanded(
                  /// List
                  child: _EventsList(
                    data: _data,
                    topHeight: topHeight,
                    blurOnScroll: true,
                    showTopGradient: false,
                  ),
                ),
                Gap($styles.insets.lg),

                /// Btn
                _TimelineBtn(type: _data.type, width: $styles.sizes.maxContentWidth3),
                Gap($styles.insets.lg),
              ],
            ),
          ],
        ),
      );
    });
  }
}
