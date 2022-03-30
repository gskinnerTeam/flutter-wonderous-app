import 'package:wonders/common_libs.dart';

class TransitionInOutBuilder extends StatefulWidget {
  const TransitionInOutBuilder({Key? key, required this.isShowing, required this.builder}) : super(key: key);
  final Widget Function(BuildContext context, Animation<double> animation) builder;
  final bool isShowing;

  @override
  State<TransitionInOutBuilder> createState() => _TransitionInOutBuilderState();
}

class _TransitionInOutBuilderState extends State<TransitionInOutBuilder> with SingleTickerProviderStateMixin {
  late final _anim = AnimationController(vsync: this, duration: context.read<AppStyle>().times.med * .75)
    ..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    if (widget.isShowing) _anim.forward(from: 0);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TransitionInOutBuilder oldWidget) {
    if (widget.isShowing != oldWidget.isShowing) {
      widget.isShowing ? _anim.forward(from: 0) : _anim.reverse(from: 1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _anim);
}
