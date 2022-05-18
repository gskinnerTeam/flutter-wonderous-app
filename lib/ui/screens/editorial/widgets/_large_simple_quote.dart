part of '../editorial_screen.dart';

class _LargeSimpleQuote extends StatelessWidget {
  const _LargeSimpleQuote({Key? key, required this.text, required this.author}) : super(key: key);
  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg, vertical: context.insets.xl),
      child: Column(children: [
        FractionalTranslation(
          translation: Offset(0, .5),
          child: Text(
            '“',
            style: context.text.quote1.copyWith(
              color: context.colors.accent1,
              fontSize: 90,
              height: .7,
            ),
          ),
        ),
        Text(
          text,
          style: context.text.quote2,
          textAlign: TextAlign.center,
        ),
        Gap(context.insets.md),
        Text(
          '- $author',
          style: context.text.quote2Sub.copyWith(color: context.colors.accent1),
        ),
      ]),
    );
  }
}
