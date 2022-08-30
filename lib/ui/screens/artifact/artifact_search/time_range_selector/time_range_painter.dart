import 'dart:typed_data';
import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_screen.dart';

class TimeRangePainter extends CustomPainter {
  final SearchVizController controller;

  TimeRangePainter({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    List<SearchData> results = controller.value;
    int l = results.length;
    if (l == 0) return;

    Paint fill = Paint()..color = controller.color.withOpacity(0.25);
    var positions = Float32List(12 * l);

    double height = size.height, width = size.width;
    int minYr = controller.minYear, delta = controller.maxYear - minYr;
    for (int i = 0; i < l; i++) {
      SearchData o = results[i];
      double x = width * (o.year - minYr) / delta;
      var j = i * 12;
      positions[j] = x - 1;
      positions[j + 1] = 0;
      positions[j + 2] = x + 1;
      positions[j + 3] = 0;
      positions[j + 4] = x - 1;
      positions[j + 5] = height;

      positions[j + 6] = x + 1;
      positions[j + 7] = 0;
      positions[j + 8] = x - 1;
      positions[j + 9] = height;
      positions[j + 10] = x + 1;
      positions[j + 11] = height;
    }
    var vertices = Vertices.raw(VertexMode.triangles, positions);
    canvas.drawVertices(vertices, BlendMode.src, fill);
  }

  @override
  bool shouldRepaint(TimeRangePainter oldDelegate) => true;
}
