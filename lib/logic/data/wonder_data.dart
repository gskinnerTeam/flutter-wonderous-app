import 'package:equatable/equatable.dart';
import 'package:wonders/logic/data/wonder_type.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

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
    required this.pullQuote1Top,
    required this.pullQuote1Bottom,
    required this.pullQuote1Author,
    this.pullQuote2 = '',
    this.pullQuote2Author = '',
    this.callout1 = '',
    this.callout2 = '',
    this.facts = const [],
    required this.historyInfo1,
    required this.historyInfo2,
    required this.constructionInfo1,
    required this.constructionInfo2,
    required this.locationInfo1,
    required this.locationInfo2,
    required this.videoId,
    this.videoCaption = '',
    this.mapCaption = '',
    required this.events,
    this.highlightArtifacts = const [],
    this.hiddenArtifacts = const [],
    this.searchData = const [],
    this.searchSuggestions = const [],
  });

  final WonderType type;
  final String title;
  final String subTitle;
  final String regionTitle;
  final String historyInfo1;
  final String historyInfo2;
  final String constructionInfo1;
  final String constructionInfo2;
  final String locationInfo1;
  final String locationInfo2;
  final String pullQuote1Top;
  final String pullQuote1Bottom;
  final String pullQuote1Author;
  final String pullQuote2;
  final String pullQuote2Author;
  final String callout1;
  final String callout2;
  final String unsplashCollectionId;
  final String videoId;
  final String videoCaption;
  final String mapCaption;
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
  final List<String> highlightArtifacts; // IDs used to assemble HighlightsData, should not be used directly
  final List<String> hiddenArtifacts; // IDs used to assemble CollectibleData, should not be used directly
  final Map<int, String> events;
  final List<SearchData> searchData;
  final List<String> searchSuggestions;

  String get titleWithBreaks => title.replaceFirst(' ', '\n');

  @override
  List<Object?> get props => [type, title, historyInfo1, imageIds, facts];
}
