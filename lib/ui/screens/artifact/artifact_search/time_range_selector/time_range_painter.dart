import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';

/// Visualizes .

class TimeRangePainter extends CustomPainter {
  final SearchVizController controller;

  // ParticleField is a ChangeNotifier, so we can use it as the repaint notifier.
  TimeRangePainter({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    List<SearchData> results = controller.value;
    int l = results.length;
    if (l == 0) return;

    Paint fill = Paint()..color = controller.color.withOpacity(0.1);

    double height = size.height, width = size.width;
    int minYr = controller.minYear, delta = controller.maxYear - minYr;
    for (int i = 0; i < l; i++) {
      SearchData o = results[i];
      double x = width * (o.year - minYr) / delta;
      canvas.drawRect(Rect.fromLTWH(x - 1, 0, 2, height), fill);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
