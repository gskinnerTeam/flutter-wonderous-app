import 'package:wonders/common_libs.dart';

class TimelineEvent {
  TimelineEvent(this.year, this.description);
  final int year;
  final String description;
}

class GlobalEventsData {
  final globalEvents = [
    TimelineEvent(-2900, $strings.timelineEvent2900bce),
    TimelineEvent(-2700, $strings.timelineEvent2700bce),
    TimelineEvent(-2600, $strings.timelineEvent2600bce),
    TimelineEvent(-2560, $strings.timelineEvent2560bce),
    TimelineEvent(-2500, $strings.timelineEvent2500bce),
    TimelineEvent(-2200, $strings.timelineEvent2200bce),
    TimelineEvent(-2000, $strings.timelineEvent2000bce),
    TimelineEvent(-1800, $strings.timelineEvent1800bce),
    TimelineEvent(-890, $strings.timelineEvent890bce),
    TimelineEvent(-776, $strings.timelineEvent776bce),
    TimelineEvent(-753, $strings.timelineEvent753bce),
    TimelineEvent(-447, $strings.timelineEvent447bce),
    TimelineEvent(-427, $strings.timelineEvent427bce),
    TimelineEvent(-322, $strings.timelineEvent322bce),
    TimelineEvent(-200, $strings.timelineEvent200bce),
    TimelineEvent(-44, $strings.timelineEvent44bce),
    TimelineEvent(-4, $strings.timelineEvent4bce),
    TimelineEvent(43, $strings.timelineEvent43ce),
    TimelineEvent(79, $strings.timelineEvent79ce),
    TimelineEvent(455, $strings.timelineEvent455ce),
    TimelineEvent(500, $strings.timelineEvent500ce),
    TimelineEvent(632, $strings.timelineEvent632ce),
    TimelineEvent(793, $strings.timelineEvent793ce),
    TimelineEvent(800, $strings.timelineEvent800ce),
    TimelineEvent(1001, $strings.timelineEvent1001ce),
    TimelineEvent(1077, $strings.timelineEvent1077ce),
    TimelineEvent(1117, $strings.timelineEvent1117ce),
    TimelineEvent(1199, $strings.timelineEvent1199ce),
    TimelineEvent(1227, $strings.timelineEvent1227ce),
    TimelineEvent(1337, $strings.timelineEvent1337ce),
    TimelineEvent(1347, $strings.timelineEvent1347ce),
    TimelineEvent(1428, $strings.timelineEvent1428ce),
    TimelineEvent(1439, $strings.timelineEvent1439ce),
    TimelineEvent(1492, $strings.timelineEvent1492ce),
    TimelineEvent(1760, $strings.timelineEvent1760ce),
    TimelineEvent(1763, $strings.timelineEvent1763ce),
    TimelineEvent(1783, $strings.timelineEvent1783ce),
    TimelineEvent(1789, $strings.timelineEvent1789ce),
    TimelineEvent(1914, $strings.timelineEvent1914ce),
    TimelineEvent(1929, $strings.timelineEvent1929ce),
    TimelineEvent(1939, $strings.timelineEvent1939ce),
    TimelineEvent(1957, $strings.timelineEvent1957ce),
    TimelineEvent(1969, $strings.timelineEvent1969ce),
  ];
}
