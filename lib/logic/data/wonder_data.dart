import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wonders/logic/data/wonder_type.dart';

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
    this.lat = 0,
    this.lng = 0,
    this.imageIds = const [],
    required this.unsplashCollectionId,
    required this.quote1,
    this.facts = const [],
    required this.historyInfo,
    required this.constructionInfo,
    required this.locationInfo,
  });

  @JsonKey(defaultValue: WonderType.chichenItza)
  final WonderType type;
  final String title;
  final String subTitle;
  final String regionTitle;
  final String historyInfo;
  final String constructionInfo;
  final String locationInfo;
  final String quote1;
  final String unsplashCollectionId;
  final List<String> imageIds;
  final List<String> facts;
  final int startYr;
  final int endYr;
  final double lat;
  final double lng;

  String get titleWithBreaks {
    final words = title.split(' ');
    if (words.length >= 2) {
      words.insert(1, '\n');
    }
    return words.join();
  }

  factory WonderData.fromJson(Map<String, dynamic> json) => _$WonderDataFromJson(json);
  Map<String, dynamic> toJson() => _$WonderDataToJson(this);

  @override
  List<Object?> get props => [type, title, historyInfo, imageIds, facts];
}
