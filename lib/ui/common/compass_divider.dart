import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';

class CompassDivider extends StatelessWidget {
  const CompassDivider({Key? key, required this.isExpanded, this.duration}) : super(key: key);
  final bool isExpanded;
  final Duration? duration;
  @override
  Widget build(BuildContext context) {
    Duration duration = this.duration ?? 1500.ms;
    Widget buildAnimatedDivider({bool alignLeft = false}) {
      return TweenAnimationBuilder<double>(
        duration: duration,
        tween: Tween(begin: 0, end: isExpanded ? 1 : 0),
        curve: Curves.easeOut,
        child: Divider(height: 1, thickness: .75, color: context.colors.accent2),
        builder: (_, value, child) {
          return Transform.scale(
            scaleX: value,
            alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: child!,
          );
        },
      );
    }

    return Row(children: [
      Expanded(child: buildAnimatedDivider()),
      Gap(context.insets.xs),
      TweenAnimationBuilder<double>(
        duration: duration,
        tween: Tween(begin: 0, end: isExpanded ? .5 : 0),
        curve: Curves.easeOutBack,
        builder: (_, value, child) => Transform.rotate(
          angle: value * pi * 2,
          child: child,
        ),
        child: SizedBox(height: 32, width: 32, child: SvgPicture.asset(SvgPaths.compassFull)),
      ),
      Gap(context.insets.xs),
      Expanded(child: buildAnimatedDivider(alignLeft: true)),
    ]);
  }
}
