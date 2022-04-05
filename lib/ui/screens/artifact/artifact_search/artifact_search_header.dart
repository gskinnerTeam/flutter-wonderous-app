import 'package:wonders/common_libs.dart';

class ArtifactSearchHeader extends StatelessWidget {
  const ArtifactSearchHeader(this.type, this.title, {Key? key}) : super(key: key);
  final WonderType type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.greyStrong,
      child: Padding(
        padding: EdgeInsets.all(context.insets.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: CloseButton(color: context.colors.bg),
            ),

            // Window title
            Padding(
              padding: EdgeInsets.only(top: context.insets.xs),
              child: Text(
                title.toUpperCase(),
                style: context.textStyles.body.copyWith(color: context.colors.bg),
              ),
            ),

            // Wonder name / culture
            Padding(
              padding: EdgeInsets.only(top: context.insets.xs),
              child: Text(
                type.name.toUpperCase(),
                style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
