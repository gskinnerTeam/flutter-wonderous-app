part of 'wonders_home_screen.dart';

class _AnimatedArrowButton extends StatelessWidget {
  const _AnimatedArrowButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double height = 60;
    const double width = 25;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: context.colors.white),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: TweenAnimationBuilder<double>(
          duration: context.times.med,
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: 1),
          builder: (_, value, __) {
            return SizedBox(
              width: width,
              height: height,
              child: Stack(children: [
                TopCenter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FractionallySizedBox(
                      heightFactor: value,
                      child: Container(color: context.colors.white, width: 2, height: 10),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -1 + value * 2),
                  child: Icon(Icons.arrow_downward, color: context.colors.white, size: 20),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
