import 'package:wonders/_tools/localization_helper.dart';

class TimelineEvent {
  TimelineEvent(this.year, this.description);
  final int year;
  final String description;
}

//
final globalEvents = [
  TimelineEvent(-2900, LocalizationHelper.instance.timelineEvent2900bce),
  TimelineEvent(-2700, LocalizationHelper.instance.timelineEvent2700bce),
  TimelineEvent(-2600, LocalizationHelper.instance.timelineEvent2600bce),
  TimelineEvent(-2560, LocalizationHelper.instance.timelineEvent2560bce),
  TimelineEvent(-2500, LocalizationHelper.instance.timelineEvent2500bce),
  TimelineEvent(-2200, LocalizationHelper.instance.timelineEvent2200bce),
  TimelineEvent(-2000, LocalizationHelper.instance.timelineEvent2000bce),
  TimelineEvent(-1800, LocalizationHelper.instance.timelineEvent1800bce),
  TimelineEvent(-890, LocalizationHelper.instance.timelineEvent890bce),
  TimelineEvent(-776, LocalizationHelper.instance.timelineEvent776bce),
  TimelineEvent(-753, LocalizationHelper.instance.timelineEvent753bce),
  TimelineEvent(-447, LocalizationHelper.instance.timelineEvent447bce),
  TimelineEvent(-427, LocalizationHelper.instance.timelineEvent427bce),
  TimelineEvent(-322, LocalizationHelper.instance.timelineEvent322bce),
  TimelineEvent(-200, LocalizationHelper.instance.timelineEvent200bce),
  TimelineEvent(-44, LocalizationHelper.instance.timelineEvent44bce),
  TimelineEvent(-4, LocalizationHelper.instance.timelineEvent4bce),
  TimelineEvent(43, LocalizationHelper.instance.timelineEvent43ce),
  TimelineEvent(79, LocalizationHelper.instance.timelineEvent79ce),
  TimelineEvent(455, LocalizationHelper.instance.timelineEvent455ce),
  TimelineEvent(500, LocalizationHelper.instance.timelineEvent500ce),
  TimelineEvent(632, LocalizationHelper.instance.timelineEvent632ce),
  TimelineEvent(793, LocalizationHelper.instance.timelineEvent793ce),
  TimelineEvent(800, LocalizationHelper.instance.timelineEvent800ce),
  TimelineEvent(1001, LocalizationHelper.instance.timelineEvent1001ce),
  TimelineEvent(1077, LocalizationHelper.instance.timelineEvent1077ce),
  TimelineEvent(1117, LocalizationHelper.instance.timelineEvent1117ce),
  TimelineEvent(1199, LocalizationHelper.instance.timelineEvent1199ce),
  TimelineEvent(1227, LocalizationHelper.instance.timelineEvent1227ce),
  TimelineEvent(1337, LocalizationHelper.instance.timelineEvent1337ce),
  TimelineEvent(1347, LocalizationHelper.instance.timelineEvent1347ce),
  TimelineEvent(1428, LocalizationHelper.instance.timelineEvent1428ce),
  TimelineEvent(1439, LocalizationHelper.instance.timelineEvent1439ce),
  TimelineEvent(1492, LocalizationHelper.instance.timelineEvent1492ce),
  TimelineEvent(1760, LocalizationHelper.instance.timelineEvent1760ce),
  TimelineEvent(1763, LocalizationHelper.instance.timelineEvent1763ce),
  TimelineEvent(1783, LocalizationHelper.instance.timelineEvent1783ce),
  TimelineEvent(1789, LocalizationHelper.instance.timelineEvent1789ce),
  TimelineEvent(1914, LocalizationHelper.instance.timelineEvent1914ce),
  TimelineEvent(1929, LocalizationHelper.instance.timelineEvent1929ce),
  TimelineEvent(1939, LocalizationHelper.instance.timelineEvent1939ce),
  TimelineEvent(1957, LocalizationHelper.instance.timelineEvent1957ce),
  TimelineEvent(1969, LocalizationHelper.instance.timelineEvent1969ce),
];
