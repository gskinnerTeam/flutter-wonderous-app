import 'package:wonders/common_libs.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class LabelledToggle extends StatelessWidget {
  const LabelledToggle(
      {Key? key,
      required optionOff,
      required optionOn,
      required this.width,
      required this.height,
      required this.isOn,
      required this.handleClick})
      : super(key: key);

  final String optionOff = '';
  final String optionOn = '';
  final double width;
  final double height;
  final bool isOn;
  final void Function() handleClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleClick,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(height)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(context.insets.xxs),
              child: AnimatedContainer(
                  transformAlignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                  width: width / 2,
                  duration: context.times.fast,
                  decoration: BoxDecoration(
                      color: context.colors.greyStrong, borderRadius: BorderRadius.all(Radius.circular(height)))),
            ),
            CenterLeft(
              child: Text(
                optionOff,
                style: context.textStyles.tab.copyWith(color: isOn ? context.colors.body : context.colors.offWhite),
              ),
            ),
            CenterRight(
              child: Text(
                optionOn,
                style: context.textStyles.tab.copyWith(color: isOn ? context.colors.offWhite : context.colors.body),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
