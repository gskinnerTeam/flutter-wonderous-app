part of '../artifact_details_screen.dart';

class _Content extends StatelessWidget {
  const _Content({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Column(
        children: [
          Gap(context.insets.xl),

          if (data.culture.isNotEmpty) ...[
            Text(
              data.culture.toUpperCase(),
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ).animate().fade(delay: 150.ms, duration: 600.ms),
            Gap(context.insets.xs),
          ],

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: context.textStyles.h2.copyWith(color: context.colors.offWhite, height: 1.2),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).animate().fade(delay: 250.ms, duration: 600.ms),

          Gap(context.insets.lg),

          Animate().toggle(delay: 500.ms, builder: (_, value, __) {
            return CompassDivider(isExpanded: !value, duration: context.times.med);
          }),

          Gap(context.insets.lg),

          ...[
            _InfoRow('Date', data.date),
            _InfoRow('Period', data.period),
            _InfoRow('Geography', data.country),
            _InfoRow('Medium', data.medium),
            _InfoRow('Dimension', data.dimension),
            _InfoRow('Classification', data.classification),
          ]
              .animate(interval: 100.ms)
              .fade(delay: 600.ms, duration: context.times.med)
              .slide(begin: Offset(0.2, 0), curve: Curves.easeOut),
          
          Gap(context.insets.offset),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value, {Key? key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.insets.sm),
      child: Row(children: [
        Expanded(
          child: Text(
            StringUtils.isEmpty(label) ? '---' : label.toUpperCase(),
            style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
          ),
        ),
        Expanded(
          child: Text(
            StringUtils.isEmpty(value) ? '---' : value,
            style: context.textStyles.body.copyWith(color: context.colors.offWhite),
          ),
        ),
      ]),
    );
  }
}
