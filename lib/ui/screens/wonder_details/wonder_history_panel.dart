import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/utils/you_tube_utils.dart';
import 'package:wonders/ui/common/placeholder_image.dart';
import 'package:wonders/ui/common/placeholder_text.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';

class WonderHistoryPanel extends StatelessWidget {
  const WonderHistoryPanel(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video('cnMa-Sm9H4k'));

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: SizedBox.shrink(),
          collapsedHeight: 80,
          flexibleSpace: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: WonderIllustration(data.type),
          )),
          expandedHeight: context.heightPct(.3),
          backgroundColor: context.colors.accent,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: SeparatedColumn(
              separatorBuilder: () => Gap(context.insets.lg),
              children: [
                PlaceholderText(count: 3),
                GestureDetector(
                  onTap: handleVideoPressed,
                  child: SizedBox(
                    height: 200,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: YouTubeUtils.getThumb('cnMa-Sm9H4k'),
                    ),
                  ),
                ),
                PlaceholderText(count: 6),
                PlaceholderImage(height: 400),
                PlaceholderText(count: 6),
                PlaceholderText(count: 4),
                PlaceholderText(count: 5),
                PlaceholderImage(height: 250),
              ],
            ),
          ),
        )
      ],
    );
  }
}
