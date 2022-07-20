import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/pyramids_giza_search_data.dart';

final pyramidsGizaData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.pyramidsGiza,
  title: LocalizationHelper.instance.pyramidsGizaTitle,
  subTitle: LocalizationHelper.instance.pyramidsGizaSubTitle,
  regionTitle: LocalizationHelper.instance.pyramidsGizaRegionTitle,
  videoId: 'lJKX3Y7Vqvs',
  startYr: -2600,
  endYr: -2500,
  artifactStartYr: -2800,
  artifactEndYr: -2300,
  artifactCulture: LocalizationHelper.instance.pyramidsGizaArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.pyramidsGizaArtifactGeolocation,
  lat: 29.976111,
  lng: 31.132778,
  unsplashCollectionId: 'CSEvB5Tza9E',
  pullQuote1Top: LocalizationHelper.instance.pyramidsGizaPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.pyramidsGizaPullQuote1Bottom,
  pullQuote1Author: '',
  pullQuote2: LocalizationHelper.instance.pyramidsGizaPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.pyramidsGizaPullQuote2Author,
  callout1: LocalizationHelper.instance.pyramidsGizaCallout1,
  callout2: LocalizationHelper.instance.pyramidsGizaCallout2,
  videoCaption: LocalizationHelper.instance.pyramidsGizaVideoCaption,
  mapCaption: LocalizationHelper.instance.pyramidsGizaMapCaption,
  historyInfo1: LocalizationHelper.instance.pyramidsGizaHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.pyramidsGizaHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.pyramidsGizaConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.pyramidsGizaConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.pyramidsGizaLocationInfo1,
  locationInfo2: LocalizationHelper.instance.pyramidsGizaLocationInfo2,
  highlightArtifacts: const [
    '543864',
    '546488',
    '557137',
    '543900',
    '543935',
    '544782',
  ],
  hiddenArtifacts: const [
    '546510',
    '543896',
    '545728',
  ],
  events: {
    -2575: LocalizationHelper.instance.pyramidsGiza2575bce,
    -2465: LocalizationHelper.instance.pyramidsGiza2465bce,
    -443: LocalizationHelper.instance.pyramidsGiza443bce,
    1925: LocalizationHelper.instance.pyramidsGiza1925ce,
    1979: LocalizationHelper.instance.pyramidsGiza1979ce,
    1990: LocalizationHelper.instance.pyramidsGiza1990ce,
  },
);
