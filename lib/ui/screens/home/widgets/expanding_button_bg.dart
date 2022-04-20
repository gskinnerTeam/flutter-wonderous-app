part of '../wonders_home_screen.dart';

class _ExpandingButtonBg extends StatelessWidget {
  const _ExpandingButtonBg({Key? key, required this.swipeController}) : super(key: key);

  final _VerticalSwipeController swipeController;
  @override
  Widget build(BuildContext context) {
    return swipeController.buildListener(
      builder: (swipeAmt, _, child) {
        double heightFactor = .5 + .5 * (1 + swipeAmt * 4);
        return FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: heightFactor,
          child: Opacity(opacity: swipeAmt * .5, child: child),
        );
      },
      child: VtGradient(
        [context.colors.white.withOpacity(0), context.colors.white.withOpacity(1)],
        const [.3, 1],
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}
