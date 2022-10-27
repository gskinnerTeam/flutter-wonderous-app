import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_backdrop.dart';
import 'package:wonders/ui/common/compass_divider.dart';
import 'package:wonders/ui/common/curved_clippers.dart';
import 'package:wonders/ui/common/hidden_collectible.dart';
import 'package:wonders/ui/common/list_gradient.dart';
import 'package:wonders/ui/common/pop_router_on_over_scroll.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/timeline_event_card.dart';
import 'package:wonders/ui/common/wonders_timeline_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part 'widgets/_events_list.dart';
part 'widgets/_top_content.dart';

class WonderEvents extends StatelessWidget {
  static const double _topHeight = 450;
  WonderEvents({Key? key, required this.type}) : super(key: key);
  final WonderType type;
  late final _data = wondersLogic.getData(type);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        color: $styles.colors.black,
        child: SafeArea(
          bottom: false,
          child: Center(
            child: SizedBox(
              width: $styles.sizes.maxContentWidth1,
              child: Stack(
                children: [
                  /// Top content, sits underneath scrolling list
                  _TopContent(data: _data),

                  /// Scrolling Events list, takes up the full view
                  _EventsList(data: _data),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
