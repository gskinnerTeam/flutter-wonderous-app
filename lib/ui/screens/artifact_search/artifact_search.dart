import 'package:wonders/common_libs.dart';
import 'expanding_time_range_selector.dart';

class ArtifactSearchScreen extends StatelessWidget {
  const ArtifactSearchScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    final data = wonders.byType(type);
    return Stack(
      children: [
        BottomCenter(
          child: ExpandingTimeRangeSelector(
            location: data.title,
            startYr: 200,
            endYr: 1400,
            onChanged: (start, end) {},
          ),
        ),
      ],
    );
  }
}
