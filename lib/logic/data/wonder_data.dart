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
    this.imageIds = const [],
    this.facts = const [],
    required this.desc,
    this.startYr = 0,
    this.endYr = 0,
    this.lat = 0,
    this.lng = 0,
  });

  @JsonKey(defaultValue: WonderType.colosseum)
  final WonderType type;
  final String title;
  final String desc;
  final List<String> imageIds;
  final List<String> facts;
  final int startYr;
  final int endYr;
  final double lat;
  final double lng;

  factory WonderData.fromJson(Map<String, dynamic> json) => _$WonderDataFromJson(json);
  Map<String, dynamic> toJson() => _$WonderDataToJson(this);

  @override
  List<Object?> get props => [type, title, desc, imageIds, facts];
}
