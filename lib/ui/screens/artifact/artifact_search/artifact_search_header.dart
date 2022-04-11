import 'package:wonders/common_libs.dart';

/// Header container for the Artifact Search view (can be used on other views as they appear). Contains close button, current Wonder type, and screen title.
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
            CenterRight(
              child: CloseButton(color: context.colors.bg),
            ),

            Gap(context.insets.xs),

            // Window title
            Text(
              title.toUpperCase(),
              style: context.textStyles.body1.copyWith(color: context.colors.bg),
            ),

            Gap(context.insets.xs),

            // Wonder name / culture
            Text(
              type.name.toUpperCase(),
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ),
          ],
        ),
      ),
    );
  }
}
