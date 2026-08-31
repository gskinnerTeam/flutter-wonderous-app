part of '../artifact_details_screen.dart';

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({super.key, required this.data});
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    final bool isScreenReaderActive = MediaQuery.of(context).accessibleNavigation && !kIsWeb;
    Widget mainElement = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap($styles.insets.xl),
        if (data.culture.isNotEmpty) ...[
          SelectableText(
            data.culture.toUpperCase(),
            style: $styles.text.titleFont.copyWith(color: $styles.colors.accent1),
          ).maybeAnimate().fade(delay: 150.delayMs, duration: 600.animateMs),
          Gap($styles.insets.xs),
        ],
        Semantics(
          header: true,
          child: SelectableText(
            data.title,
            textAlign: TextAlign.center,
            style: $styles.text.h2.copyWith(color: $styles.colors.offWhite, height: 1.2),
            maxLines: 5,
          ).maybeAnimate().fade(delay: 250.delayMs, duration: 600.animateMs),
        ),
        Gap($styles.insets.lg),
        Animate().toggle(
          delay: 500.delayMs,
          builder: (_, value, __) {
            return CompassDivider(isExpanded: !value, duration: $styles.times.med);
          },
        ),
        Gap($styles.insets.lg),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...[
                  _InfoRow($strings.artifactDetailsLabelDate, data.date),
                  _InfoRow($strings.artifactDetailsLabelPeriod, data.period),
                  _InfoRow($strings.artifactDetailsLabelGeography, data.country),
                  _InfoRow($strings.artifactDetailsLabelMedium, data.medium),
                  _InfoRow($strings.artifactDetailsLabelDimension, data.dimension),
                  _InfoRow($strings.artifactDetailsLabelClassification, data.classification),
                ]
                .animate(interval: 100.delayMs)
                .fadeIn(delay: 600.delayMs, duration: $styles.times.med)
                .slide(begin: Offset(0.2, 0), curve: Curves.easeOut),
          ],
        ),
        Gap($styles.insets.md),
        SelectableText(
          $strings.homeMenuAboutMet,
          style: $styles.text.caption.copyWith(color: $styles.colors.accent2),
        ).maybeAnimate(delay: 1500.delayMs).fadeIn().slide(begin: Offset(0.2, 0), curve: Curves.easeOut),
        Gap($styles.insets.offset),
      ],
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
        child: Focus(
          canRequestFocus: isScreenReaderActive,
          includeSemantics: isScreenReaderActive,
          child: mainElement,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value, {super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    bool shortMode = context.widthPx < 800;

    List<Expanded> infoChildren = [
      Expanded(
        flex: shortMode ? 0 : 40,
        child: SelectableText(
          label.toUpperCase(),
          style: $styles.text.titleFont.copyWith(color: $styles.colors.accent2),
        ),
      ),
      Expanded(
        flex: shortMode ? 0 : 60,
        child: SelectableText(
          value.isEmpty ? '--' : value,
          style: $styles.text.body.copyWith(color: $styles.colors.offWhite),
        ),
      ),
    ];

    return ExcludeSemantics(
      excluding: value.isEmpty,
      child: MergeSemantics(
        child: Padding(
          padding: EdgeInsets.only(bottom: $styles.insets.sm),
          child: shortMode
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: infoChildren,
                )
              : Row(children: infoChildren),
        ),
      ),
    );
  }
}
