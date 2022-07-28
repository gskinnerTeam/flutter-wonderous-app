import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';

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
    // The relative widths of the text itself.
    double offWidth = StringUtils.measure(optionOff, $styles.text.btn).width;
    double onWidth = StringUtils.measure(optionOn, $styles.text.btn).width;

    // Get the width of the row with text and padding.
    double maxWidth = offWidth + onWidth + $styles.insets.xl + $styles.insets.sm * 4;

    // Manual height.
    double maxHeight = $styles.insets.xl;

    // Colors and styles for the labels.
    TextStyle textOffColor = $styles.text.btn.copyWith(
      color: isOn ? $styles.colors.body : $styles.colors.offWhite,
    );
    TextStyle textOnColor = textOffColor.copyWith(
      color: isOn ? $styles.colors.offWhite : $styles.colors.body,
    );

    BoxDecoration circleDec = BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(maxHeight)));
    return AppBtn.basic(
      onPressed: onClick,
      semanticLabel: $strings.labelledToggleSemanticToggle,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: maxWidth,
          height: maxHeight,
          decoration: circleDec,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                width: double.infinity,
                height: constraints.maxHeight,
                decoration: circleDec.copyWith(
                  color: $styles.colors.black.withOpacity(0.1),
                ),
              ),

              // Switch BG
              Padding(
                padding: EdgeInsets.all($styles.insets.xxs),
                child: AnimatedAlign(
                  duration: $styles.times.fast,
                  curve: Curves.easeInOut,
                  alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: $styles.times.fast,
                    curve: Curves.easeInOut,
                    width: isOn
                        ? onWidth + $styles.insets.sm * 3 + $styles.insets.xs
                        : offWidth + $styles.insets.sm * 3 + $styles.insets.xs,
                    decoration: circleDec.copyWith(color: $styles.colors.greyStrong),
                  ),
                ),
              ),

              // Inner text
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap($styles.insets.sm),
                      Flexible(
                        child: Text(
                          optionOff,
                          style: textOffColor,
                        ),
                      ),
                      Gap($styles.insets.xl),
                      Flexible(
                        child: Text(
                          optionOn,
                          style: textOnColor,
                        ),
                      ),
                      Gap($styles.insets.sm),
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
