import 'package:json_annotation/json_annotation.dart';
import 'package:wonders/logic/data/artifact_data.dart';

part 'timeline_data.g.dart';

@JsonSerializable()
class TimelineData {
  TimelineData({required this.artifacts, required this.events});
  final List<ArtifactData> artifacts;
  final List<TimelineEvent> events;
  /*
  events
  artifacts
   */
  factory TimelineData.fromJson(Map<String, dynamic> json) => _$TimelineDataFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineDataToJson(this);
}

@JsonSerializable()
class TimelineEvent {
  TimelineEvent({required this.title, required this.string, required this.image, required this.year});
  final int year;
  final String title;
  final String string;
  final String image;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) => _$TimelineEventFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineEventToJson(this);
}
