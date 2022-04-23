part of '../artifact_details_screen.dart';

class _Content extends StatelessWidget {
  const _Content({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    const double _textHeight = 1.2;
    final animDelay = 250.ms;
    final animDuration = context.times.slow * .5;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(context.insets.lg),

          // Wonder Type
          Text(
            data.culture.toUpperCase(),
            style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
          ).fx().fade(delay: animDelay, duration: animDuration),

          Gap(context.insets.sm),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: context.textStyles.h2.copyWith(color: context.colors.offWhite, height: _textHeight),
          ).fx().fade(delay: animDelay * 1.05, duration: animDuration),

          Gap(context.insets.xxl),

          FXRunAnimated((_, value) {
            return CompassDivider(isExpanded: !value, duration: context.times.med);
          }, delay: animDelay * 1.5),

          Gap(context.insets.xxl),

          // Description
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ArtifactDataRow(title: 'Date', content: data.date),
              _ArtifactDataRow(title: 'Period', content: data.period),
              _ArtifactDataRow(title: 'Geography', content: data.country),
              _ArtifactDataRow(title: 'Medium', content: data.medium),
              _ArtifactDataRow(title: 'Dimension', content: data.dimension),
              _ArtifactDataRow(title: 'Classification', content: data.classification),
              Gap(context.heightPx * .15),
            ]
                .fx(interval: 70.ms)
                .fade(delay: animDelay * 1.55, duration: context.times.med)
                .slide(begin: Offset(.2, 0), curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }
}