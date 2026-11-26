part of '../timeline_screen.dart';

class _YearMarkers extends StatelessWidget {
  _YearMarkers();

  int get startYr => wondersLogic.timelineStartYear;
  int get endYr => wondersLogic.timelineEndYear;

  late final int _totalYrs = endYr - startYr;

  /// Normalizes a given year to a value from 0 - 1, based on start and end yr.
  double _calculateOffsetY(int yr) => (yr - startYr) / _totalYrs;

  @override
  Widget build(BuildContext context) {
    return IgnorePointerKeepSemantics(
      child: LayoutBuilder(
        builder: (_, constraints) {
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
              duration: $styles.times.med,
              child: Stack(
                key: ValueKey(interval),
                children: markers.map((yr) {
                  return _YearMarker(yr, _calculateOffsetY(yr));
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _YearMarker extends StatelessWidget {
  const _YearMarker(this.yr, this.offset);
  final int yr;
  final double offset;

  /// Right edge of the year labels when text is scaled up, leaving room for the event markers that sit to their right.
  static const double scaledTextRightInset = 32;

  @override
  Widget build(BuildContext context) {
    // Once text is scaled up, centred years grow into the event markers, so right-align them just short of the markers.
    final bool scaledText = MediaQuery.textScalerOf(context).scale(1) > 1;
    return ExcludeSemantics(
      child: Align(
        alignment: Alignment(0, -1 + offset * 2),

        // Use an OverflowBox wrapped in a zero-height sized box so that al
        // This allows alignment-based positioning to be accurate even at the edges of the parent.
        child: SizedBox(
          height: 0,
          child: OverflowBox(
            alignment: scaledText ? Alignment.topRight : Alignment.topCenter,
            maxHeight: 100,
            maxWidth: 100,
            child: Padding(
              padding: EdgeInsets.only(right: scaledText ? scaledTextRightInset : 0),
              child: FractionalTranslation(
                translation: Offset(0, -.5),
                // Years are a single line; at large text sizes shrink to fit the column instead of wrapping digits.
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${yr.abs()}',
                    maxLines: 1,
                    softWrap: false,
                    style: $styles.text.body.copyWith(color: Colors.white, height: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        //child:,
      ),
    );
  }
}
