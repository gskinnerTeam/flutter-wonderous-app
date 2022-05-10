import 'package:wonders/common_libs.dart';

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
            borderRadius: BorderRadius.all(Radius.circular(context.corners.sm)),
          ),
          child: Checkbox(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(context.corners.sm))),
              value: active,
              visualDensity: VisualDensity(horizontal: 0.5, vertical: 0.5),
              checkColor: context.colors.black.withOpacity(0.75),
              activeColor: context.colors.white.withOpacity(0.75),
              onChanged: onToggled),
        ),
        Gap(context.insets.xs),
        Text(label, style: context.textStyles.body.copyWith(color: context.colors.offWhite)),
      ],
    );
  }
}
