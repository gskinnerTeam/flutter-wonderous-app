part of '../editorial_screen.dart';

class _ScrollingContent extends StatelessWidget {
  const _ScrollingContent(this.data, {Key? key, required this.scrollPos, required this.sectionNotifier})
      : super(key: key);
  final WonderData data;
  final ValueNotifier<double> scrollPos;
  final ValueNotifier<int> sectionNotifier;

  @override
  Widget build(BuildContext context) {
    Text buildText(String value) => Text(_fixNewlines(value), style: context.textStyles.body1);
    DropCapText buildDropCapText(String value) => DropCapText(
          _fixNewlines(value),
          mode: DropCapMode.upwards,
          style: context.textStyles.body1,
          dropCapPadding: EdgeInsets.only(right: context.insets.xs, top: 10),
          dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1),
        );

    return Container(
      color: context.colors.offWhite,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          // TODO: temporary for testing. Remove.
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CollectibleItem(collectibles[0]),
            CollectibleItem(collectibles[1]),
            CollectibleItem(collectibles[2]),
          ]),
          buildDropCapText(data.historyInfo1),
          _CollapsingPullQuoteImage(data: data, scrollPos: scrollPos),
          buildText(data.historyInfo2),
          _SectionDivider(scrollPos, sectionNotifier, index: 1),
          buildDropCapText(data.constructionInfo1),
          _YouTubeThumbnail(id: data.videoId),
          buildText(data.constructionInfo2),
          _SlidingImageStack(scrollPos: scrollPos, type: data.type),
          _SectionDivider(scrollPos, sectionNotifier, index: 2),
          buildDropCapText(data.locationInfo),
          PlaceholderImage(height: 200),
        ],
      ),
    );
  }

  String _fixNewlines(String text) {
    const nl = '\n';
    final chunks = text.split(nl);
    while (chunks.last == nl) {
      chunks.removeLast();
    }
    chunks.removeWhere((element) => element.trim().isEmpty);
    final result = chunks.join('$nl$nl');
    return result;
  }
}

class _YouTubeThumbnail extends StatelessWidget {
  const _YouTubeThumbnail({Key? key, required this.id}) : super(key: key);
  final String id;

  String get imageUrl => 'http://img.youtube.com/vi/$id/hqdefault.jpg';

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video(id));
    return SizedBox(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: GestureDetector(
          onTap: handleVideoPressed,
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}