// Adds duration extensions to num, so they are available on double and int.
//    200.ms // equivalent to Duration(milliseconds: 200)
//    3.25.seconds // equivalent to Duration(milliseconds: 3250)
//    1.5.days // equivalent to Duration(hours: 36)
extension NumDurationExtensions on num {
  Duration get microseconds => Duration(microseconds: round());
  Duration get milliseconds => Duration(microseconds: (this*1000.0).round());
  Duration get seconds => Duration(microseconds: (this*1000.0*1000.0).round());
  Duration get minutes => Duration(microseconds: (this*1000.0*1000.0*60.0).round());
  Duration get hours => Duration(microseconds: (this*1000.0*1000.0*60.0*60.0).round());
  Duration get days => Duration(microseconds: (this*1000.0*1000.0*60.0*60.0*24.0).round());
  Duration get ms => milliseconds;
}