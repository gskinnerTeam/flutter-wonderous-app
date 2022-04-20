import 'package:wonders/common_libs.dart';

class CollectionProgressBar extends StatelessWidget {
  const CollectionProgressBar(this.count, this.total, {Key? key}) : super(key: key);

  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.insets.xs,
      decoration: BoxDecoration(
        color: context.colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.accent1,
          borderRadius: BorderRadius.circular(1000),
        ),
      ).fx().fade(duration: 1500.ms, curve: Curves.easeOutExpo).build((_, m, child) =>
          FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: m * count / total, child: child)),
    );
  }
}
