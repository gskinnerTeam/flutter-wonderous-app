part of '../timeline_screen.dart';

class _EventMarkers extends StatelessWidget {
  _EventMarkers({Key? key}) : super(key: key);

  int get startYr => wondersLogic.startYear;
  int get endYr => wondersLogic.endYear;

  late final int _totalYrs = endYr - startYr;

  /// Normalizes a given year to a value from 0 - 1, based on start and end yr.
  double calculateOffsetY(int yr) => (yr - startYr) / _totalYrs;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(builder: (_, constraints) {
        return SizedBox(
          width: 100,
          child: Stack(
            children: globalEvents.entries.map((event) {
              return _EventMarker(calculateOffsetY(event.key));
            }).toList(),
          ),
        );
      }),
    );
  }
}

class _EventMarker extends StatelessWidget {
  const _EventMarker(this.offset, {Key? key}) : super(key: key);
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1 + offset * 2),
      child: FractionalTranslation(
        translation: Offset(0, 0),
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: context.colors.accent1,
          ),
        ),
      ),
    );
  }
}
