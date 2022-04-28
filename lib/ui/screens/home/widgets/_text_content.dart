part of '../wonders_home_screen.dart';

class _TextContent extends StatelessWidget {
  const _TextContent({Key? key, required this.wonderIndex, required this.wonders}) : super(key: key);

  final int wonderIndex;
  final List<WonderData> wonders;

  @override
  Widget build(BuildContext context) {
    final currentWonder = wonders[wonderIndex];
    // TODO: Consolidate app shadows in styles.shadows? Note: Lets see how it develops, not sure there is enough to standardize
    final textShadows = [
      Shadow(color: Colors.black.withOpacity(.6), offset: Offset(0, 2), blurRadius: 2),
    ];
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 220 * context.style.scale),
      child: Column(
        children: [
          /// Page indicator
          DiagonalPageIndicator(current: wonderIndex + 1, total: wonders.length),
          Gap(context.insets.sm),

          /// Title
          WonderTitleText(currentWonder, enableShadows: true),
          Gap(context.insets.sm),

          /// Region
          Text(
            currentWonder.regionTitle.toUpperCase(),
            style: context.textStyles.h4.copyWith(
              height: 1,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              shadows: textShadows,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
