import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/string_utils.dart';

class ArtifactDataElement extends StatelessWidget {
  const ArtifactDataElement({Key? key, this.title, this.content}) : super(key: key);
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    // Note: Flutter's syntax correction does not believe StringUtils.isEmpty is a null check,
    // so this is to remove the error that a String? cannot be assigned to a String.
    String t = StringUtils.isEmpty(title) ? '---' : title ?? '---';
    String c = StringUtils.isEmpty(content) ? '---' : content ?? '---';

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
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
            ),
          ),
          Expanded(
            child: Text(
              c,
              style: context.textStyles.body.copyWith(color: context.colors.bg),
            ),
          ),
        ],
      ),
    );
  }
}
