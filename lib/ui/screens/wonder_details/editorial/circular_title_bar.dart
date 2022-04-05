part of 'wonder_editorial_screen.dart';

class _CircularTitleBar extends StatelessWidget {
  const _CircularTitleBar({Key? key, required this.titles, required this.index}) : super(key: key);
  final List<String> titles;
  final int index;

  @override
  Widget build(BuildContext context) {
    double circleSize = 190;
    double barSize = 105;
    assert(index >= 0 && index < titles.length, 'Can not find a title for index $index');
    return SizedBox(
      height: barSize,
      child: Stack(
        children: [
          BottomCenter(child: Container(height: barSize - 40, color: context.colors.bg)),
          Center(
            child: ClipRect(
              child: UnconstrainedBox(
                child: Transform.translate(
                  offset: Offset(0, (circleSize - barSize) / 2),
                  child: SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: context.colors.bg),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: AnimatedSwitcher(
                          duration: context.times.fast,
                          child: CircularText(
                            children: [
                              TextItem(
                                text: Text(
                                  titles[index].toUpperCase(),
                                  style: context.textStyles.h1.copyWith(fontSize: 24, color: context.colors.accent1),
                                ),
                                space: 10,
                                startAngle: -90,
                                startAngleAlignment: StartAngleAlignment.center,
                                direction: CircularTextDirection.clockwise,
                              ),
                            ],
                            radius: 125,
                            position: CircularTextPosition.inside,
                          ).gTweener.rotate(from: -180).withDuration(context.times.med).withKey(ValueKey(index)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
