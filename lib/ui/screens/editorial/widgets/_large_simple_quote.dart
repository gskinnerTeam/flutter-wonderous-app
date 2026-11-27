part of '../editorial_screen.dart';

class _LargeSimpleQuote extends StatelessWidget {
  const _LargeSimpleQuote({required this.text, required this.author});
  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      // The quote is large display text in a narrow box, so cap how far it scales; beyond this, words break mid-word.
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.5,
        child: CenteredBox(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.xl),
          child: Column(
            children: [
              FractionalTranslation(
                translation: Offset(0, .5),
                child: Text(
                  '“',
                  style: $styles.text.quote1.copyWith(
                    color: $styles.colors.accent3,
                    fontSize: 90 * $styles.scale,
                    height: .7,
                  ),
                ),
              ),
              Text(
                text,
                style: $styles.text.quote2,
                textAlign: TextAlign.center,
              ),
              Gap($styles.insets.md),
              Text(
                '- $author',
                style: $styles.text.quote2Sub.copyWith(color: $styles.colors.accent3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
