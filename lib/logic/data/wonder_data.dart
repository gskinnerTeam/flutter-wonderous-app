import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wonders/logic/data/wonder_type.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'wonder_data.g.dart';

@JsonSerializable()
@CopyWith()
class WonderData extends Equatable {
  const WonderData({
    required this.type,
    required this.title,
    required this.subTitle,
    required this.regionTitle,
    this.startYr = 0,
    this.endYr = 0,
    this.artifactStartYr = 0,
    this.artifactEndYr = 0,
    this.artifactCulture = '',
    this.artifactGeolocation = '',
    this.lat = 0,
    this.lng = 0,
    this.imageIds = const [],
    required this.unsplashCollectionId,
    required this.quote1,
    required this.quote2,
    required this.quoteAuthor,
    this.facts = const [],
    required this.historyInfo1,
    required this.historyInfo2,
    required this.constructionInfo1,
    required this.constructionInfo2,
    required this.locationInfo,
    required this.videoId,
    required this.events,
    this.highlightArtifacts = const [],
    this.hiddenArtifacts = const [],
    this.searchData = const [],
  });

  @JsonKey(defaultValue: WonderType.chichenItza)
  final WonderType type;
  final String title;
  final String subTitle;
  final String regionTitle;
  final String historyInfo1;
  final String historyInfo2;
  final String constructionInfo1;
  final String constructionInfo2;
  final String locationInfo;
  final String quote1;
  final String quote2;
  final String quoteAuthor;
  final String unsplashCollectionId;
  final String videoId;
  final List<String> imageIds;
  final List<String> facts;
  final int startYr;
  final int endYr;
  final int artifactStartYr;
  final int artifactEndYr;
  final String artifactCulture;
  final String artifactGeolocation;
  final double lat;
  final double lng;
  final List<String> highlightArtifacts;
  final List<String> hiddenArtifacts;
  final Map<int, String> events;
  final List<SearchData> searchData;

  String get titleWithBreaks => title.replaceFirst(' ', '\n');

  factory WonderData.fromJson(Map<String, dynamic> json) => _$WonderDataFromJson(json);
  Map<String, dynamic> toJson() => _$WonderDataToJson(this);

  @override
  List<Object?> get props => [type, title, historyInfo1, imageIds, facts];
}
