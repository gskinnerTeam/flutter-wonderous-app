import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/unsplash_photo.dart';
import 'package:wonders/ui/screens/artifact_search/expanding_time_range_selector.dart';

class ArtifactSearchScreen extends StatelessWidget {
  const ArtifactSearchScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    final data = wonders.byType(type);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(opacity: .5, child: UnsplashPhoto('_iklK8oQKPs', targetSize: 600, fit: BoxFit.cover)),
          ),
          BottomCenter(
            child: ExpandingTimeRangeSelector(
              location: data.title,
              startYr: 200,
              endYr: 1400,
              onChanged: (start, end) {},
            ),
          ),
        ],
      ),
    );
  }
}
