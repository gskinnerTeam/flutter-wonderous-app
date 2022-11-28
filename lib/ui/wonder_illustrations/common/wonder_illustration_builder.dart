import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

/// Takes a builder for each of the 3 illustration layers.
/// Each builder returns a list of Widgets which will be added directly to a Stack.
/// Checks the config, and only calls builders that are currently enabled.
///
/// Also manages an AnimationController that is passed to each layer if it would like to animate itself on or off screen.
class WonderIllustrationBuilder extends StatefulWidget {
  const WonderIllustrationBuilder({
    Key? key,
    required this.config,
    required this.fgBuilder,
    required this.mgBuilder,
    required this.bgBuilder,
    required this.wonderType,
  }) : super(key: key);
  final List<Widget> Function(BuildContext context, Animation<double> animation) fgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation) mgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation) bgBuilder;
  final WonderIllustrationConfig config;
  final WonderType wonderType;

  @override
  State<WonderIllustrationBuilder> createState() => WonderIllustrationBuilderState();
}

class WonderIllustrationBuilderState extends State<WonderIllustrationBuilder> with SingleTickerProviderStateMixin {
  late final anim = AnimationController(vsync: this, duration: $styles.times.med * .75)
    ..addListener(() => setState(() {}));

  bool get isShowing => widget.config.isShowing;
  @override
  void initState() {
    super.initState();
    if (isShowing) anim.forward(from: 0);
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WonderIllustrationBuilder oldWidget) {
    if (isShowing != oldWidget.config.isShowing) {
      isShowing ? anim.forward(from: 0) : anim.reverse(from: 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: no need to return all of these children if the widget is fully invisible.
    if (anim.value == 0 && widget.config.enableAnims) return SizedBox.expand();
    Animation<double> animation = widget.config.enableAnims ? anim : AlwaysStoppedAnimation(1);

    return Provider<WonderIllustrationBuilderState>.value(
      value: this,
      child: Stack(
        key: ValueKey(animation.value == 0),
        children: [
          if (widget.config.enableBg) ...widget.bgBuilder(context, animation),
          if (widget.config.enableMg) ...widget.mgBuilder(context, animation),
          if (widget.config.enableFg) ...widget.fgBuilder(context, animation),
        ],
      ),
    );
  }
}
