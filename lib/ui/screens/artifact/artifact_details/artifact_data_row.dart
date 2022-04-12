part of 'artifact_details_screen.dart';

class ArtifactDataRow extends StatelessWidget {
  const ArtifactDataRow({Key? key, required this.title, required this.content}) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    const double _textHeight = 1.2;
    String t = StringUtils.isEmpty(title) ? '---' : title;
    String c = StringUtils.isEmpty(content) ? '---' : content;

    return Padding(
      padding: EdgeInsets.only(bottom: context.insets.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              t.toUpperCase(),
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent2, height: _textHeight),
            ),
          ),
          Expanded(
            child: Text(
              c,
              style: context.textStyles.body1.copyWith(color: context.colors.bg, height: _textHeight),
            ),
          ),
        ],
      ),
    );
  }
}
