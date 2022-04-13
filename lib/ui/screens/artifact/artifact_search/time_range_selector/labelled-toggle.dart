import 'package:wonders/common_libs.dart';

// Expandable timerange selector component that further refines Artifact Search based on date range.
class LabbeledToggle extends StatelessWidget {
  const LabbeledToggle({Key? key, required optionA, required optionB, required this.width, required this.height})
      : super(key: key);

  final String optionA = '';
  final String optionB = '';
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(height)),
        ));
  }
}
