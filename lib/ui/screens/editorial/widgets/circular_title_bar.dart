part of '../editorial_screen.dart';

class _CircularTitleBar extends StatelessWidget {
  const _CircularTitleBar({Key? key, required this.titles, required this.index}) : super(key: key);
  final List<String> titles;
  final int index;

  @override
  Widget build(BuildContext context) {
    double barSize = 105; // the actual size of this widget
    double barTopPadding = 40; // negative space at the top of the bar
    double circleSize = 190; // circle is bigger than bar, and overhangs it
    assert(index >= 0 && index < titles.length, 'Can not find a title for index $index');
    return SizedBox(
      height: barSize,
      child: Stack(
        children: [
          // Bg
          BottomCenter(child: Container(height: barSize - barTopPadding, color: context.colors.bg)),

          ClipRect(
            child: OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: circleSize,
              child: _AnimatedCircleWithText(titles: titles, index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCircleWithText extends StatefulWidget {
  const _AnimatedCircleWithText({
    Key? key,
    required this.titles,
    required this.index,
  }) : super(key: key);

  final List<String> titles;
  final int index;

  @override
  State<_AnimatedCircleWithText> createState() => _AnimatedCircleWithTextState();
}

class _AnimatedCircleWithTextState extends State<_AnimatedCircleWithText> with SingleTickerProviderStateMixin {
  int _prevIndex = -1;
  String get oldTitle => _prevIndex == -1 ? '' : widget.titles[_prevIndex];
  String get newTitle => widget.titles[widget.index];
  late final _anim = AnimationController(
    vsync: this,
    duration: context.times.fast,
  )..forward();

  bool get isAnimStopped => _anim.value == 0 || _anim.value == _anim.upperBound;

  @override
  void didUpdateWidget(covariant _AnimatedCircleWithText oldWidget) {
    // Spin 180 degrees each time index changes
    if (oldWidget.index != widget.index) {
      _prevIndex = oldWidget.index;
      // If the animation is already in motion, we don't need to interrupt it, just let the text change
      if (isAnimStopped) {
        _anim.forward(from: 0);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(_) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) => Transform.rotate(
        angle: Curves.easeInOut.transform(_anim.value) * pi,
        child: child,
      ),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: context.colors.bg),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(24),
          // 2 circles that are counter rotated / opposite (one on top, one on bottom)
          // Each time index is changed, the stack is rotated 180 degrees.
          // When the animation completes, the rotation snaps back to 0 and the titles also swap position
          // This creates the effect of a new title always rolling in, with the old rolling out
          child: Stack(
            children: [
              Transform.rotate(
                  angle: _anim.isCompleted ? pi : 0,
                  child: _buildCircularText(_anim.isCompleted ? newTitle : oldTitle)),
              Transform.rotate(
                angle: _anim.isCompleted ? 0 : pi,
                child: _buildCircularText(_anim.isCompleted ? oldTitle : newTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircularText _buildCircularText(String title) {
    final textStyle = context.textStyles.h1.copyWith(fontSize: 24, color: context.colors.accent1);
    return CircularText(
      radius: 125,
      position: CircularTextPosition.inside,
      children: [
        TextItem(
          text: Text(title.toUpperCase(), style: textStyle),
          space: 10,
          startAngle: -90,
          startAngleAlignment: StartAngleAlignment.center,
          direction: CircularTextDirection.clockwise,
        ),
      ],
    );
  }
}
