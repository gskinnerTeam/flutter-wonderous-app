part of '../wonders_home_screen.dart';

class _TextContent extends StatelessWidget {
  const _TextContent({Key? key, required this.wonderIndex, required this.wonders}) : super(key: key);

  final int wonderIndex;
  final List<WonderData> wonders;

  @override
  Widget build(BuildContext context) {
    final currentWonder = wonders[wonderIndex];
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 230 * context.style.scale),
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
              shadows: context.shadows.text,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
