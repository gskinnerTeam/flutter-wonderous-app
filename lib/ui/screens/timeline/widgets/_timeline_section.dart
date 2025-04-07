part of '../timeline_screen.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection(this.data, this.selectedYr, {super.key, required this.selectedWonder});
  final WonderData data;
  final int selectedYr;
  final WonderType? selectedWonder;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedWonder == data.type;
    // get a fraction from 0 - 1 based on selected yr and start/end yr of the wonder
    // 500, 250, 750
    int startYr = data.startYr, endYr = data.endYr;
    double fraction = (selectedYr - startYr) / (endYr - startYr);
    fraction = fraction.clamp(0, 1);

    return Semantics(
      label: '${data.title}, ${$strings.timelineSemanticDate(
        StringUtils.formatYr(data.startYr),
        StringUtils.formatYr(data.endYr),
      )}',
      child: IgnorePointerKeepSemantics(
        child: Container(
          alignment: Alignment(0, -1 + fraction * 2),
          padding: EdgeInsets.all($styles.insets.xs),
          decoration: BoxDecoration(color: data.type.fgColor),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: BlendMask(
              blendModes: isSelected ? [] : const [BlendMode.luminosity],
              opacity: .6,
              child: _buildWonderImage(),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildWonderImage() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: data.type.bgColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment(0, -.5),
          image: AssetImage(data.type.flattened),
        ),
      ),
    );
  }
}
