part of '../timeline_screen.dart';

class _YearMarkers extends StatelessWidget {
  _YearMarkers({Key? key}) : super(key: key);

  int get startYr => wondersLogic.startYear;
  int get endYr => wondersLogic.endYear;

  late final int _totalYrs = endYr - startYr;

  /// Normalizes a given year to a value from 0 - 1, based on start and end yr.
  double calculateOffsetY(int yr) => (yr - startYr) / _totalYrs;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(builder: (_, constraints) {
        int interval = 100;
        if (constraints.maxHeight < 800) {
          interval = 500;
        } else if (constraints.maxHeight < 1500) {
          interval = 250;
        }

        // If interval is 100 and time is 0 - 1000 yrs, make a list of 11 items:
        // [0, 100, 200, ..., 1000 ]
        int numMarkers = (_totalYrs / interval).round() + 1;
        late final markers = List.generate(numMarkers, (i) {
          return startYr + i * interval;
        });

        return SizedBox(
          width: 100,
          child: AnimatedSwitcher(
            duration: context.times.med,
            child: Stack(
              key: ValueKey(interval),
              children: markers.map((yr) {
                return _Marker(yr, calculateOffsetY(yr));
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}

class _Marker extends StatelessWidget {
  const _Marker(this.yr, this.offset, {Key? key}) : super(key: key);
  final int yr;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1 + offset * 2),
      child: FractionalTranslation(
        translation: Offset(0, 0),
        child: Text('$yr', style: context.text.body.copyWith(color: Colors.white, height: 1)),
      ),
    );
  }
}
