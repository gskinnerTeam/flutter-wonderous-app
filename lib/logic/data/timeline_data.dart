import 'package:wonders/common_libs.dart';

class TimelineEvent {
  TimelineEvent(this.year, this.description);
  final int year;
  final String description;
}

class GlobalEventsData {
  final globalEvents = [
    TimelineEvent(-2900, localizationsLogic.instance.timelineEvent2900bce),
    TimelineEvent(-2700, localizationsLogic.instance.timelineEvent2700bce),
    TimelineEvent(-2600, localizationsLogic.instance.timelineEvent2600bce),
    TimelineEvent(-2560, localizationsLogic.instance.timelineEvent2560bce),
    TimelineEvent(-2500, localizationsLogic.instance.timelineEvent2500bce),
    TimelineEvent(-2200, localizationsLogic.instance.timelineEvent2200bce),
    TimelineEvent(-2000, localizationsLogic.instance.timelineEvent2000bce),
    TimelineEvent(-1800, localizationsLogic.instance.timelineEvent1800bce),
    TimelineEvent(-890, localizationsLogic.instance.timelineEvent890bce),
    TimelineEvent(-776, localizationsLogic.instance.timelineEvent776bce),
    TimelineEvent(-753, localizationsLogic.instance.timelineEvent753bce),
    TimelineEvent(-447, localizationsLogic.instance.timelineEvent447bce),
    TimelineEvent(-427, localizationsLogic.instance.timelineEvent427bce),
    TimelineEvent(-322, localizationsLogic.instance.timelineEvent322bce),
    TimelineEvent(-200, localizationsLogic.instance.timelineEvent200bce),
    TimelineEvent(-44, localizationsLogic.instance.timelineEvent44bce),
    TimelineEvent(-4, localizationsLogic.instance.timelineEvent4bce),
    TimelineEvent(43, localizationsLogic.instance.timelineEvent43ce),
    TimelineEvent(79, localizationsLogic.instance.timelineEvent79ce),
    TimelineEvent(455, localizationsLogic.instance.timelineEvent455ce),
    TimelineEvent(500, localizationsLogic.instance.timelineEvent500ce),
    TimelineEvent(632, localizationsLogic.instance.timelineEvent632ce),
    TimelineEvent(793, localizationsLogic.instance.timelineEvent793ce),
    TimelineEvent(800, localizationsLogic.instance.timelineEvent800ce),
    TimelineEvent(1001, localizationsLogic.instance.timelineEvent1001ce),
    TimelineEvent(1077, localizationsLogic.instance.timelineEvent1077ce),
    TimelineEvent(1117, localizationsLogic.instance.timelineEvent1117ce),
    TimelineEvent(1199, localizationsLogic.instance.timelineEvent1199ce),
    TimelineEvent(1227, localizationsLogic.instance.timelineEvent1227ce),
    TimelineEvent(1337, localizationsLogic.instance.timelineEvent1337ce),
    TimelineEvent(1347, localizationsLogic.instance.timelineEvent1347ce),
    TimelineEvent(1428, localizationsLogic.instance.timelineEvent1428ce),
    TimelineEvent(1439, localizationsLogic.instance.timelineEvent1439ce),
    TimelineEvent(1492, localizationsLogic.instance.timelineEvent1492ce),
    TimelineEvent(1760, localizationsLogic.instance.timelineEvent1760ce),
    TimelineEvent(1763, localizationsLogic.instance.timelineEvent1763ce),
    TimelineEvent(1783, localizationsLogic.instance.timelineEvent1783ce),
    TimelineEvent(1789, localizationsLogic.instance.timelineEvent1789ce),
    TimelineEvent(1914, localizationsLogic.instance.timelineEvent1914ce),
    TimelineEvent(1929, localizationsLogic.instance.timelineEvent1929ce),
    TimelineEvent(1939, localizationsLogic.instance.timelineEvent1939ce),
    TimelineEvent(1957, localizationsLogic.instance.timelineEvent1957ce),
    TimelineEvent(1969, localizationsLogic.instance.timelineEvent1969ce),
  ];
}
