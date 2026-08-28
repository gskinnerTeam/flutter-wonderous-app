part of '../editorial_screen.dart';

class _Callout extends StatelessWidget {
  final String text;

  const _Callout({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    final bool isScreenReaderActive = MediaQuery.of(context).accessibleNavigation && !kIsWeb;
    Widget mainElement = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(color: $styles.colors.accent1, width: 1),
          Gap($styles.insets.sm),
          Expanded(
            child: Text(
              text,
              style: $styles.text.callout,
            ),
          ),
        ],
      ),
    );
    return Focus(
      canRequestFocus: isScreenReaderActive,
      includeSemantics: isScreenReaderActive,
      child: mainElement,
    );
  }
}
