part of '../wonder_events.dart';

class _TimelineBtn extends StatelessWidget {
  const _TimelineBtn({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    void handleBtnPressed() => context.push(ScreenPaths.timeline(type));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      child: AppBtn.from(
        text: $strings.eventsListButtonOpenGlobal,
        expand: true,
        onPressed: handleBtnPressed,
        semanticLabel: $strings.eventsListButtonOpenGlobal,
      ),
    );
  }
}
