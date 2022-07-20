import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/christ_redeemer_search_data.dart';

final christRedeemerData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.christRedeemer,
  title: LocalizationHelper.instance.christRedeemerTitle,
  subTitle: LocalizationHelper.instance.christRedeemerSubTitle,
  regionTitle: LocalizationHelper.instance.christRedeemerRegionTitle,
  videoId: 'k_615AauSds',
  startYr: 1922,
  endYr: 1931,
  artifactStartYr: 1600,
  artifactEndYr: 2100,
  artifactCulture: '',
  artifactGeolocation: LocalizationHelper.instance.christRedeemerArtifactGeolocation,
  lat: -22.95238891944396,
  lng: -43.21045520611561,
  unsplashCollectionId: 'dPgX5iK8Ufo',
  pullQuote1Top: LocalizationHelper.instance.christRedeemerPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.christRedeemerPullQuote1Bottom,
  pullQuote1Author: '',
  pullQuote2: LocalizationHelper.instance.christRedeemerPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.christRedeemerPullQuote2Author,
  callout1: LocalizationHelper.instance.christRedeemerCallout1,
  callout2: LocalizationHelper.instance.christRedeemerCallout2,
  videoCaption: LocalizationHelper.instance.christRedeemerVideoCaption,
  mapCaption: LocalizationHelper.instance.christRedeemerMapCaption,
  historyInfo1: LocalizationHelper.instance.christRedeemerHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.christRedeemerHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.christRedeemerConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.christRedeemerConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.christRedeemerLocationInfo1,
  locationInfo2: LocalizationHelper.instance.christRedeemerLocationInfo2,
  highlightArtifacts: const [
    '501319',
    '764815',
    '502019',
    '764814',
    '764816',
  ],
  hiddenArtifacts: const [
    '501302',
    '157985',
    '227759',
  ],
  events: {
    1850: LocalizationHelper.instance.christRedeemer1850ce,
    1921: LocalizationHelper.instance.christRedeemer1921ce,
    1922: LocalizationHelper.instance.christRedeemer1922ce,
    1926: LocalizationHelper.instance.christRedeemer1926ce,
    1931: LocalizationHelper.instance.christRedeemer1931ce,
    2006: LocalizationHelper.instance.christRedeemer2006ce,
  },
);
