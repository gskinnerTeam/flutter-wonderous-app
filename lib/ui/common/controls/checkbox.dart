import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/app_haptics.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox({Key? key, required this.active, required this.onToggled, required this.label})
      : super(key: key);
  final bool active;
  final String label;
  final Function(bool? onToggle) onToggled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular($styles.corners.sm)),
          ),
          child: Checkbox(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular($styles.corners.sm))),
              value: active,
              visualDensity: VisualDensity(horizontal: 0.5, vertical: 0.5),
              checkColor: $styles.colors.black.withOpacity(0.75),
              activeColor: $styles.colors.white.withOpacity(0.75),
              onChanged: (bool? active) {
                AppHaptics.mediumImpact();
                onToggled.call(active);
              }),
        ),
        Gap($styles.insets.xs),
        Text(label, style: $styles.text.body.copyWith(color: $styles.colors.offWhite)),
      ],
    );
  }
}
