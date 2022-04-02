part of 'wonder_editorial_screen.dart';

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Gap(context.insets.md),
          Gap(30),
          SeparatedRow(
            padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
            separatorBuilder: () => Gap(context.insets.sm),
            children: [
              Expanded(child: Divider().gTweener.scale(curve: Curves.easeOut).withDelay(.5.seconds)),
              Text(
                data.subTitle.toUpperCase(),
                style: context.textStyles.body.copyWith(color: context.colors.accent2),
              ),
              Expanded(child: Divider().gTweener.scale(curve: Curves.easeOut).withDelay(.5.seconds)),
            ],
          ),
          Gap(context.insets.md),
          Text(
            data.title.toUpperCase(),
            style: context.textStyles.h1.copyWith(color: context.colors.bg),
            textAlign: TextAlign.center,
          ).gTweener.fade().withDuration(context.times.slow).withDelay(.3.seconds),
          Gap(30),
          Gap(context.insets.md),
        ],
      );
}
