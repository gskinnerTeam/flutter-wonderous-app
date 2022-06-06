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
  }) : super(key: key);
  final List<Widget> Function(BuildContext context, Animation<double> animation) fgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation) mgBuilder;
  final List<Widget> Function(BuildContext context, Animation<double> animation) bgBuilder;
  final WonderIllustrationConfig config;

  @override
  State<WonderIllustrationBuilder> createState() => _WonderIllustrationBuilderState();
}

class _WonderIllustrationBuilderState extends State<WonderIllustrationBuilder> with SingleTickerProviderStateMixin {
  late final _anim = AnimationController(vsync: this, duration: $styles.times.med * .75)
    ..addListener(() => setState(() {}));

  bool get isShowing => widget.config.isShowing;
  @override
  void initState() {
    super.initState();
    if (isShowing) _anim.forward(from: 0);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WonderIllustrationBuilder oldWidget) {
    if (isShowing != oldWidget.config.isShowing) {
      isShowing ? _anim.forward(from: 0) : _anim.reverse(from: 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: no need to return all of these children if the widget is fully invisible.
    if (_anim.value == 0 && widget.config.enableAnims) return SizedBox.expand();
    Animation<double> anim = widget.config.enableAnims ? _anim : AlwaysStoppedAnimation(1);

    return Stack(key: ValueKey(anim.value == 0), children: [
      if (widget.config.enableBg) ...widget.bgBuilder(context, _anim),
      if (widget.config.enableMg) ...widget.mgBuilder(context, _anim),
      if (widget.config.enableFg) ...widget.fgBuilder(context, _anim),
    ]);
  }
}
