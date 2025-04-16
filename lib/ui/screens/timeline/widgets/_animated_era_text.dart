part of '../timeline_screen.dart';

class _AnimatedEraText extends StatelessWidget {
  const _AnimatedEraText(this.year);
  final int year;

  @override
  Widget build(BuildContext context) {
    String era = StringUtils.getEra(year);
    final style = $styles.text.body.copyWith(color: $styles.colors.offWhite);
    return Semantics(
      liveRegion: true,
      child: Text(era, style: style),
    ).maybeAnimate(key: ValueKey(era)).fadeIn().slide(begin: Offset(0, .2));
  }
}
