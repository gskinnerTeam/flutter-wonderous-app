part of '../collection_screen.dart';

@immutable
class _CollectionHeader extends StatelessWidget {
  const _CollectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Container(
            width: context.insets.lg * 2,
            height: context.insets.offset,
            alignment: Alignment.centerRight,
            child: CircleIconBtn(
              icon: Icons.arrow_back,
              onPressed: () => context.pop(),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              'Collection'.toUpperCase(),
              textAlign: TextAlign.center,
              style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
            ),
          ),
          Gap(context.insets.lg * 2),
        ]),
      ]),
    );
  }
}
