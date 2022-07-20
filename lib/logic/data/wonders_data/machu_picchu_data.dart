import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/machu_picchu_search_data.dart';

final machuPicchuData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.machuPicchu,
  title: LocalizationHelper.instance.machuPicchuTitle,
  subTitle: LocalizationHelper.instance.machuPicchuSubTitle,
  regionTitle: LocalizationHelper.instance.machuPicchuRegionTitle,
  videoId: 'cnMa-Sm9H4k',
  startYr: 1450,
  endYr: 1572,
  artifactStartYr: 1200,
  artifactEndYr: 1700,
  artifactCulture: LocalizationHelper.instance.machuPicchuArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.machuPicchuArtifactGeolocation,
  lat: -13.162690683637758,
  lng: -72.54500778824891,
  unsplashCollectionId: 'wUhgZTyUnl8',
  pullQuote1Top: LocalizationHelper.instance.machuPicchuPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.machuPicchuPullQuote1Bottom,
  pullQuote1Author: LocalizationHelper.instance.machuPicchuPullQuote1Author,
  pullQuote2: LocalizationHelper.instance.machuPicchuPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.machuPicchuPullQuote2Author,
  callout1: LocalizationHelper.instance.machuPicchuCallout1,
  callout2: LocalizationHelper.instance.machuPicchuCallout2,
  videoCaption: LocalizationHelper.instance.machuPicchuVideoCaption,
  mapCaption: LocalizationHelper.instance.machuPicchuMapCaption,
  historyInfo1: LocalizationHelper.instance.machuPicchuHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.machuPicchuHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.machuPicchuConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.machuPicchuConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.machuPicchuLocationInfo1,
  locationInfo2: LocalizationHelper.instance.machuPicchuLocationInfo2,
  highlightArtifacts: const [
    '313295',
    '316926',
    '309944',
    '309436',
    '309960',
    '316873',
  ],
  hiddenArtifacts: const [
    '308120',
    '309960',
    '313341',
  ],
  events: {
    1438: LocalizationHelper.instance.machuPicchu1438ce,
    1572: LocalizationHelper.instance.machuPicchu1572ce,
    1867: LocalizationHelper.instance.machuPicchu1867ce,
    1911: LocalizationHelper.instance.machuPicchu1911ce,
    1964: LocalizationHelper.instance.machuPicchu1964ce,
    1997: LocalizationHelper.instance.machuPicchu1997ce,
  },
);
