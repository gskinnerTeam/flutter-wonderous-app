part of '../editorial_screen.dart';

class _ScrollingContent extends StatelessWidget {
  const _ScrollingContent(this.data, {Key? key, required this.scrollNotifier, required this.sectionNotifier})
      : super(key: key);
  final WonderData data;
  final ValueNotifier<double> scrollNotifier;
  final ValueNotifier<int> sectionNotifier;

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video('cnMa-Sm9H4k'));
    return Container(
      color: context.colors.bg,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          DropCapText(
            _formatText(data.historyInfo),
            style: context.textStyles.body,
            dropCapPadding: EdgeInsets.only(right: context.insets.xs, top: 10),
            dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1),
          ),
          _SectionDivider(scrollNotifier, sectionNotifier, index: 1),
          DropCapText(
            _formatText(data.locationInfo),
            style: context.textStyles.body,
            dropCapPadding: EdgeInsets.only(right: context.insets.xs, top: 10),
            dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1),
          ),
          _SectionDivider(scrollNotifier, sectionNotifier, index: 2),
          DropCapText(
            _formatText(data.constructionInfo),
            style: context.textStyles.body,
            dropCapPadding: EdgeInsets.only(right: context.insets.xs, top: 10),
            dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1),
          ),
        ],
      ),
    );
  }

  String _formatText(String text) {
    const nl = '\n';
    final chunks = text.split(nl);
    if (chunks.last == nl) chunks.removeLast();
    return chunks.join('$nl$nl');
  }
}
