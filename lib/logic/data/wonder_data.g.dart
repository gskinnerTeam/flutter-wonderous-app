// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wonder_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WonderDataCWProxy {
  WonderData desc(String desc);

  WonderData endYr(int endYr);

  WonderData facts(List<String> facts);

  WonderData imageUrls(List<String> imageUrls);

  WonderData lat(double lat);

  WonderData lng(double lng);

  WonderData startYr(int startYr);

  WonderData title(String title);

  WonderData type(WonderType type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WonderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WonderData(...).copyWith(id: 12, name: "My name")
  /// ````
  WonderData call({
    String? desc,
    int? endYr,
    List<String>? facts,
    List<String>? imageUrls,
    double? lat,
    double? lng,
    int? startYr,
    String? title,
    WonderType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWonderData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWonderData.copyWith.fieldName(...)`
class _$WonderDataCWProxyImpl implements _$WonderDataCWProxy {
  final WonderData _value;

  const _$WonderDataCWProxyImpl(this._value);

  @override
  WonderData desc(String desc) => this(desc: desc);

  @override
  WonderData endYr(int endYr) => this(endYr: endYr);

  @override
  WonderData facts(List<String> facts) => this(facts: facts);

  @override
  WonderData imageUrls(List<String> imageUrls) => this(imageUrls: imageUrls);

  @override
  WonderData lat(double lat) => this(lat: lat);

  @override
  WonderData lng(double lng) => this(lng: lng);

  @override
  WonderData startYr(int startYr) => this(startYr: startYr);

  @override
  WonderData title(String title) => this(title: title);

  @override
  WonderData type(WonderType type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WonderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WonderData(...).copyWith(id: 12, name: "My name")
  /// ````
  WonderData call({
    Object? desc = const $CopyWithPlaceholder(),
    Object? endYr = const $CopyWithPlaceholder(),
    Object? facts = const $CopyWithPlaceholder(),
    Object? imageUrls = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? startYr = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return WonderData(
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      endYr: endYr == const $CopyWithPlaceholder() || endYr == null
          ? _value.endYr
          // ignore: cast_nullable_to_non_nullable
          : endYr as int,
      facts: facts == const $CopyWithPlaceholder() || facts == null
          ? _value.facts
          // ignore: cast_nullable_to_non_nullable
          : facts as List<String>,
      imageUrls: imageUrls == const $CopyWithPlaceholder() || imageUrls == null
          ? _value.imageUrls
          // ignore: cast_nullable_to_non_nullable
          : imageUrls as List<String>,
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as double,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as double,
      startYr: startYr == const $CopyWithPlaceholder() || startYr == null
          ? _value.startYr
          // ignore: cast_nullable_to_non_nullable
          : startYr as int,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as WonderType,
    );
  }
}

extension $WonderDataCopyWith on WonderData {
  /// Returns a callable class that can be used as follows: `instanceOfclass WonderData extends Equatable.name.copyWith(...)` or like so:`instanceOfclass WonderData extends Equatable.name.copyWith.fieldName(...)`.
  _$WonderDataCWProxy get copyWith => _$WonderDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WonderData _$WonderDataFromJson(Map<String, dynamic> json) => WonderData(
      type: $enumDecodeNullable(_$WonderTypeEnumMap, json['type']) ?? WonderType.petra,
      title: json['title'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      facts: (json['facts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      desc: json['desc'] as String,
      startYr: json['startYr'] as int? ?? 0,
      endYr: json['endYr'] as int? ?? 0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$WonderDataToJson(WonderData instance) => <String, dynamic>{
      'type': _$WonderTypeEnumMap[instance.type],
      'title': instance.title,
      'desc': instance.desc,
      'imageUrls': instance.imageUrls,
      'facts': instance.facts,
      'startYr': instance.startYr,
      'endYr': instance.endYr,
      'lat': instance.lat,
      'lng': instance.lng,
    };

const _$WonderTypeEnumMap = {
  WonderType.petra: 'petra',
  WonderType.machuPicchu: 'machuPicchu',
};
