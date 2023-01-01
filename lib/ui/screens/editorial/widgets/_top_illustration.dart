part of '../editorial_screen.dart';

class _TopIllustration extends StatelessWidget {
  const _TopIllustration(this.type, {Key? key}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WonderIllustration(type, config: WonderIllustrationConfig.bg(enableAnims: false, shortMode: true)),
        Transform.translate(
          // Small bump down to make sure we cover the edge between the editorial page and the sky.
          offset: Offset(0, 10),
          child: WonderIllustration(
            type,
            config: WonderIllustrationConfig.mg(enableAnims: false, shortMode: true),
          ),
        ),
      ],
    );
  }
}
