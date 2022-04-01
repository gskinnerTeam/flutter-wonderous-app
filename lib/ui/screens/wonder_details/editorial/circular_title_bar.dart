part of 'wonder_editorial_screen.dart';

/// TODO: Add declarative list of headings, and a currentIndex value
class _CircularTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double circleSize = 190;
    double barSize = 124;
    return SizedBox(
      height: barSize,
      child: Stack(
        children: [
          BottomCenter(child: Container(height: 80, color: context.colors.bg)),
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
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                "Facts and History".toUpperCase(),
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
                        ),
                      ),
                      // child: Text(
                      //   'Facts and History'.toUpperCase(),
                      //   style: context.textStyles.h1.copyWith(
                      //     fontSize: 15,
                      //     color: context.colors.accent1,
                      //   ),
                      // ),
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
