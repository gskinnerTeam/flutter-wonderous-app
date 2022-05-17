part of '../timeline_screen.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection(this.data, this.selectedYr, {Key? key, required this.selectedWonder}) : super(key: key);
  final WonderData data;
  final int selectedYr;
  final WonderType? selectedWonder;

  @override
  Widget build(BuildContext context) {
    /// TODO: Remove isSelected state completely if design is ok with it
    bool isSelected = selectedWonder == data.type;
    // get a fraction from 0 - 1 based on selected yr and start/end yr of the wonder
    // 500, 250, 750
    int startYr = data.startYr, endYr = data.endYr;
    double fraction = (selectedYr - startYr) / (endYr - startYr);
    fraction = fraction.clamp(0, 1);

    return Container(
      alignment: Alignment(0, -1 + fraction * 2),
      padding: EdgeInsets.all(context.insets.xs),
      decoration: BoxDecoration(color: data.type.fgColor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: BlendMask(
          blendModes: isSelected ? [] : const [BlendMode.luminosity],
          opacity: .6,
          child: _buildWonderImage(),
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
