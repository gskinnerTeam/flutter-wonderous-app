part of 'wonder_editorial_screen.dart';

class _TopIllustration extends StatelessWidget {
  const _TopIllustration(this.type, {Key? key}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WonderIllustration(type, config: WonderIllustrationConfig.bg(enableAnims: false)),
        Transform.translate(
          offset: Offset(0, 60),
          child: Transform.scale(
            scale: .95,
            child: WonderIllustration(
              type,
              config: WonderIllustrationConfig.mg(enableAnims: false),
            ),
          ),
        ),
      ],
    );
  }
}