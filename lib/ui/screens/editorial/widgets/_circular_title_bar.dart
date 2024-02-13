part of '../editorial_screen.dart';

class _CircularTitleBar extends StatelessWidget {
  const _CircularTitleBar({Key? key, required this.titles, required this.icons, required this.index})
      : assert(titles.length == icons.length, 'The number of titles and icons do not match.'),
        super(key: key);
  final List<String> titles;
  final List<String> icons;
  final int index;

  @override
  Widget build(BuildContext context) {
    double barSize = 100; // the actual size of this widget
    double barTopPadding = 40; // negative space at the top of the bar
    double circleSize = 190; // circle is bigger than bar, and overhangs it
    assert(index >= 0 && index < titles.length, 'Can not find a title for index $index');
    // note: this offset eliminates a subpixel line Flutter draws below the header
    return Transform.translate(
      offset: Offset(0, 1),
      child: SizedBox(
        height: barSize,
        child: Stack(
          children: [
            // Bg
            BottomCenter(child: Container(height: barSize - barTopPadding, color: $styles.colors.offWhite)),

            ClipRect(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: circleSize,
                child: _AnimatedCircleWithText(titles: titles, index: index),
              ),
            ),

            BottomCenter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset('${ImagePaths.common}/${icons[index]}').animate(key: ValueKey(index)).fade().scale(
                    begin: Offset(.5, .5), end: Offset(1, 1), curve: Curves.easeOutBack, duration: $styles.times.med),
              ),
            ),
          ],
        ),
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
    duration: $styles.times.med,
  )..forward();

  bool get isAnimStopped => _anim.value == 0 || _anim.value == _anim.upperBound;

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

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
      builder: (_, __) {
        var rot = _prevIndex > widget.index ? -pi : pi;
        return Transform.rotate(
          angle: Curves.easeInOut.transform(_anim.value) * rot,
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: $styles.colors.offWhite),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16),
              // 2 circles that are counter rotated / opposite (one on top, one on bottom)
              // Each time index is changed, the stack is rotated 180 degrees.
              // When the animation completes, the rotation snaps back to 0 and the titles also swap position
              // This creates the effect of a new title always rolling in, with the old rolling out
              child: Semantics(
                label: newTitle,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: _anim.isCompleted ? rot : 0,
                      child: _buildCircularText(_anim.isCompleted ? newTitle : oldTitle),
                    ),
                    if (!_anim.isCompleted) ...[
                      Transform.rotate(
                        angle: _anim.isCompleted ? 0 : rot,
                        child: _buildCircularText(_anim.isCompleted ? oldTitle : newTitle),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircularText(String title) {
    final textStyle = $styles.text.monoTitleFont.copyWith(
      fontSize: 22 * $styles.scale,
      color: $styles.colors.accent1,
    );
    return CircularText(
      position: CircularTextPosition.inside,
      children: [
        TextItem(
          text: Text(title.toUpperCase(), style: textStyle),
          space: 9,
          startAngle: -90,
          startAngleAlignment: StartAngleAlignment.center,
          direction: CircularTextDirection.clockwise,
        ),
      ],
    );
  }
}
