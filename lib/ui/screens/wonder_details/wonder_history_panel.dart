import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/utils/you_tube_utils.dart';
import 'package:wonders/ui/common/placeholder_image.dart';
import 'package:wonders/ui/common/placeholder_text.dart';

class WonderHistoryPanel extends StatelessWidget {
  const WonderHistoryPanel(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video('cnMa-Sm9H4k'));
    void _handleBackPressed() => context.pop();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Placeholder(
            fallbackHeight: 500,
          ),
        ),
        SliverAppBar(
          pinned: true,
          collapsedHeight: 130,
          expandedHeight: 500,
          backgroundColor: context.colors.accent1,
          leading: SizedBox.shrink(),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(context.insets.md),
              child: SizedBox.shrink(), // WonderIllustration(data.type),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(context.insets.md),
            child: SeparatedColumn(
              separatorBuilder: () => Gap(context.insets.md),
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
        ),
        SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
