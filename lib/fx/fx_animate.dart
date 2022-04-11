part of 'fx.dart';

// FXAnimate makes adding beautiful animated effects (FX) to your widgets
// simple. It supports both a declarative and chained API. The latter is exposed
// via the `Widget.fx` extension, which simply wraps the widget in FXAnimate.
//
//    FXAnimate(child: foo, fx: [FadeFX(), ScaleFX()])
//    foo.fx.fade().scale() // equivalent to above
//
// All effects classes are immutable, and can be shared between FXAnimate
// instances, which lets you create libraries of effects to reuse throughout
// your app.
//
//    FadeFX fadeIn = FadeFX(duration: 100.ms, curve: Curves.easeOut);
//    ScaleFX scaleIn = ScaleFX(begin: 0.8, curve: Curves.easeIn);
//    List<AbstractFX> transitionIn = [fadeIn, scaleIn];
//    // then:
//    FXAnimate(child: foo, fx:transitionIn)
//    foo.fx(fx:transitionIn)
//
// Effects inherit some of their properties (delay, duration, curve) from
// previous effects if unspecified. So in the examples above, the scale will use
// the same duration as the fade that precedes it. All effects also have
// reasonable defaults, so they can be used simply: `foo.fx.fade()`

// ignore: must_be_immutable
class FXAnimate extends StatefulWidget with FXManager<FXAnimate> {
  static Duration defaultDuration = const Duration(milliseconds: 1000);
  static Curve defaultCurve = Curves.linear;

  final Widget child;
  late final List<FXEntry> _fx;
  Duration _offset = Duration.zero;
  Duration _duration = Duration.zero;
  FXEntry? _lastEntry;
  FXAnimateCallback? onComplete;
  FXAnimateCallback? onInit; // todo: FXController

  FXAnimate(
      {Key? key,
      required this.child,
      List<AbstractFX>? fx,
      this.onComplete,
      this.onInit})
      : super(key: key) {
    _fx = [];
    if (fx != null) {
      addFXList(fx);
    }
  }

  FXAnimate call(
      {List<AbstractFX>? fx,
      FXAnimateCallback? onComplete,
      FXAnimateCallback? onInit}) {
    if (_fx.isNotEmpty) {
      // throw error?
      return this;
    }
    this.onComplete = onComplete;
    this.onInit = onInit;
    if (fx != null) {
      addFXList(fx);
    }
    return this;
  }

  Duration get duration => _duration;

  @override
  State<FXAnimate> createState() => _FXAnimateState();

  @override
  FXAnimate addFX(AbstractFX fx) {
    Duration begin =
        _offset + (fx.delay ?? _lastEntry?.fx.delay ?? Duration.zero);
    FXEntry entry = FXEntry(
      fx: fx,
      begin: begin,
      end: begin +
          (fx.duration ?? _lastEntry?.fx.duration ?? FXAnimate.defaultDuration),
      curve: fx.curve ?? _lastEntry?.curve ?? FXAnimate.defaultCurve,
    );
    _fx.add(entry);
    _lastEntry = entry;
    if (entry.end > _duration) {
      _duration = entry.end;
    }
    return this;
  }

  @override
  FXAnimate addFXList(List<AbstractFX> fx) {
    for (AbstractFX o in fx) {
      addFX(o);
    }
    return this;
  }
}

class _FXAnimateState extends State<FXAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    _controller.duration = widget._duration;
    if (widget.onComplete != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete!(_controller);
        }
      });
    }
    if (widget.onInit != null) {
      widget.onInit!(_controller);
    }
    _controller.forward();
    for (FXEntry entry in widget._fx) {
      child = entry.fx.build(context, child, _controller, entry);
    }
    return child;
  }
}

extension FXWidgetExtensions on Widget {
  FXAnimate get fx => FXAnimate(child: this);
}
