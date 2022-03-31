import 'package:wonders/common_libs.dart';

class SearchScreenHeader extends StatelessWidget {
  const SearchScreenHeader(this.type, this.title, {Key? key}) : super(key: key);
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
                  alignment: Alignment.bottomRight,
                  child: const CloseButton(),
                ),

                // Window title
                Padding(
                  padding: EdgeInsets.only(top: context.insets.xs),
                  child: Text(
                    title,
                    style: context.textStyles.body.copyWith(color: context.colors.bg),
                  ),
                ),

                // Wonder name / culture
                Padding(
                  padding: EdgeInsets.only(top: context.insets.xs),
                  child: Text(
                    type.name,
                    style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
                  ),
                ),
              ])),
    );
  }
}
