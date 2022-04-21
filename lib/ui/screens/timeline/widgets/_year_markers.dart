part of '../timeline_screen.dart';

class _YearMarkers extends StatelessWidget {
  _YearMarkers({Key? key, required this.startYr, required this.endYr}) : super(key: key);
  final int startYr;
  final int endYr;
  late final int _totalYrs = endYr - startYr;

  Widget buildMarker(int yr) {
    // Calculate the fraction of this yr based on the total range
    final offsetY = (yr - startYr) / _totalYrs;
    return Align(
      alignment: Alignment(0, -1 + offsetY * 2),
      child: FractionalTranslation(
        translation: Offset(0, -.5),
        child: Text('$yr', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      int interval = 100;
      if (constraints.maxHeight < 800) {
        interval = 500;
      } else if (constraints.maxHeight < 1500) {
        interval = 250;
      }

      // If interval is 100 and time is 0 - 1000 yrs, make a list of [0, 100, 200, ... ]
      late final markers = List.generate(
        (_totalYrs / interval).round() + 1,
        (i) => startYr + i * interval,
      );

      return Stack(children: markers.map(buildMarker).toList());
    });
  }
}
