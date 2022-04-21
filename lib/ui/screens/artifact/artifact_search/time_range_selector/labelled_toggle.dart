import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/ui/common/blend_mask.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class LabelledToggle extends StatelessWidget {
  const LabelledToggle(
      {Key? key, required this.optionOff, required this.optionOn, required this.isOn, required this.onClick})
      : super(key: key);

  final String optionOff;
  final String optionOn;
  final bool isOn;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    double offWidth = StringUtils.measure(optionOff, context.textStyles.tab).width;
    double onWidth = StringUtils.measure(optionOn, context.textStyles.tab).width;

    // Get the width of the row with text and padding.
    double maxWidth = offWidth + onWidth + context.insets.xl + context.insets.sm * 4;

    // Manual height.
    double maxHeight = context.insets.xl;

    return GestureDetector(
      onTap: onClick,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: maxWidth,
          height: maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(maxHeight)),
          ),
          child: Stack(
            fit: StackFit.loose,
            children: [
              // Mask for background blending
              BlendMask(
                blendModes: const [BlendMode.dstOut],
                opacity: 0.8,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration:
                      BoxDecoration(color: context.colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),

              // Switch BG
              Padding(
                padding: EdgeInsets.all(context.insets.xxs),
                child: Align(
                  alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: isOn
                        ? onWidth + context.insets.sm * 3 + context.insets.xs
                        : offWidth + context.insets.sm * 3 + context.insets.xs,
                    decoration: BoxDecoration(
                      color: context.colors.greyStrong,
                      borderRadius: BorderRadius.all(
                        Radius.circular(maxHeight),
                      ),
                    ),
                  ),
                ),
              ),

              // Inner text
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.insets.sm),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(context.insets.sm),
                      Flexible(
                        child: Text(
                          optionOff,
                          style: context.textStyles.tab
                              .copyWith(color: isOn ? context.colors.body : context.colors.offWhite),
                        ),
                      ),
                      Gap(context.insets.xl),
                      Flexible(
                        child: Text(
                          optionOn,
                          style: context.textStyles.tab
                              .copyWith(color: isOn ? context.colors.offWhite : context.colors.body),
                        ),
                      ),
                      Gap(context.insets.sm),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
