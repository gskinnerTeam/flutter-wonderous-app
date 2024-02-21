part of '../artifact_details_screen.dart';

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({super.key, required this.data});
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap($styles.insets.xl),
            if (data.culture.isNotEmpty) ...[
              Text(
                data.culture.toUpperCase(),
                style: $styles.text.titleFont.copyWith(color: $styles.colors.accent1),
              ).animate().fade(delay: 150.ms, duration: 600.ms),
              Gap($styles.insets.xs),
            ],
            Semantics(
              header: true,
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: $styles.text.h2.copyWith(color: $styles.colors.offWhite, height: 1.2),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ).animate().fade(delay: 250.ms, duration: 600.ms),
            ),
            Gap($styles.insets.lg),
            Animate().toggle(
                delay: 500.ms,
                builder: (_, value, __) {
                  return CompassDivider(isExpanded: !value, duration: $styles.times.med);
                }),
            Gap($styles.insets.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...[
                  _InfoRow($strings.artifactDetailsLabelDate, data.date),
                  _InfoRow($strings.artifactDetailsLabelPeriod, data.period),
                  _InfoRow($strings.artifactDetailsLabelGeography, data.country),
                  _InfoRow($strings.artifactDetailsLabelMedium, data.medium),
                  _InfoRow($strings.artifactDetailsLabelDimension, data.dimension),
                  _InfoRow($strings.artifactDetailsLabelClassification, data.classification),
                ]
                    .animate(interval: 100.ms)
                    .fadeIn(delay: 600.ms, duration: $styles.times.med)
                    .slide(begin: Offset(0.2, 0), curve: Curves.easeOut),
              ],
            ),
            Gap($styles.insets.md),
            Text(
              $strings.homeMenuAboutMet,
              style: $styles.text.caption.copyWith(color: $styles.colors.accent2),
            ).animate(delay: 1.5.seconds).fadeIn().slide(begin: Offset(0.2, 0), curve: Curves.easeOut),
            Gap($styles.insets.offset),
          ],
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
    return ExcludeSemantics(
      excluding: value.isEmpty,
      child: MergeSemantics(
        child: Padding(
          padding: EdgeInsets.only(bottom: $styles.insets.sm),
          child: Row(children: [
            Expanded(
              flex: 40,
              child: Text(
                label.toUpperCase(),
                style: $styles.text.titleFont.copyWith(color: $styles.colors.accent2),
              ),
            ),
            Expanded(
              flex: 60,
              child: Text(
                value.isEmpty ? '--' : value,
                style: $styles.text.body.copyWith(color: $styles.colors.offWhite),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
