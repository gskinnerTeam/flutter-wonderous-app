part of 'fx.dart';


// Lets you trigger the animation of an `Animated` widget
// (ex. `AnimatedContainer`) immediately or after a delay. This is achieved via
// a builder method that accepts a boolean state: true for the start, false for 
// the end.
//
// For example, this would result in a rectangle that fades from red to blue:
//
//    FXRunAnimated(
//      delay: 200.ms,
//      builder: (_, b) => AnimatedContainer(
//        duration: 500.ms,
//        color: b ? Colors.red : Colors.blue,
//      )
//    )
class FXRunAnimated extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;
  final Duration delay;

  const FXRunAnimated(this.builder,
      {this.delay = const Duration(milliseconds: 1), Key? key})
      : super(key: key);

  FXRunAnimated.swap(Widget start, Widget end,
      {this.delay = const Duration(milliseconds: 1), Key? key})
      : builder = ((context, state) => state ? start : end),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _FXRunAnimatedState();
}

class _FXRunAnimatedState extends State<FXRunAnimated> {
  bool state = true;

  @override
  void initState() {
    Future.delayed(
        widget.delay,
        () => setState(() {
              state = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
