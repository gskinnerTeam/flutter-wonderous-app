import 'package:wonders/common_libs.dart';

class ArtifactSearchHeader extends StatelessWidget {
  const ArtifactSearchHeader(this.type, this.title, {Key? key}) : super(key: key);
  final WonderType type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.greyStrong,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.xs),
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
          Text(
            title.toUpperCase(),
            style: context.textStyles.body1.copyWith(color: context.colors.bg),
          ),

          // Wonder name / culture
          Text(
            type.name.toUpperCase(),
            style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
          ),
        ],
      ),
    );
  }
}
