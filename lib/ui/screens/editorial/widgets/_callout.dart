part of '../editorial_screen.dart';

class _Callout extends StatelessWidget {
  final String text;

  const _Callout({required this.text});
  @override
  Widget build(BuildContext context) {
    return Focus(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(color: $styles.colors.accent1, width: 1),
            Gap($styles.insets.sm),
            Expanded(child: Text(text, style: $styles.text.callout)),
          ],
        ),
      ),
    );
  }
}
