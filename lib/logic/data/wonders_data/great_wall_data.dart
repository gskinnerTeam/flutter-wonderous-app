import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/great_wall_search_data.dart';

final greatWallData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.greatWall,
  title: LocalizationHelper.instance.greatWallTitle,
  subTitle: LocalizationHelper.instance.greatWallSubTitle,
  regionTitle: LocalizationHelper.instance.greatWallRegionTitle,
  videoId: 'do1Go22Wu8o',
  startYr: -700,
  endYr: 1644,
  artifactStartYr: -700,
  artifactEndYr: 1650,
  artifactCulture: LocalizationHelper.instance.greatWallArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.greatWallArtifactGeolocation,
  lat: 40.43199751120627,
  lng: 116.57040708482984,
  unsplashCollectionId: 'Kg_h04xvZEo',
  pullQuote1Top: LocalizationHelper.instance.greatWallPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.greatWallPullQuote1Bottom,
  pullQuote1Author: '', //No key because it doesn't generate for empty values
  pullQuote2: LocalizationHelper.instance.greatWallPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.greatWallPullQuote2Author,
  callout1: LocalizationHelper.instance.greatWallCallout1,
  callout2: LocalizationHelper.instance.greatWallCallout2,
  videoCaption: LocalizationHelper.instance.greatWallVideoCaption,
  mapCaption: LocalizationHelper.instance.greatWallMapCaption,
  historyInfo1: LocalizationHelper.instance.greatWallHistoryInfo1, 
  historyInfo2: LocalizationHelper.instance.greatWallHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.greatWallConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.greatWallConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.greatWallLocationInfo1,
  locationInfo2: LocalizationHelper.instance.greatWallLocationInfo2,
  highlightArtifacts: const [
    '79091',
    '781812',
    '40213',
    '40765',
    '57612',
    '666573',
  ],
  hiddenArtifacts: const [
    '39918',
    '39666',
    '39735',
  ],
  events: {
    -700: LocalizationHelper.instance.greatWall700bce,
    -214: LocalizationHelper.instance.greatWall214bce,
    -121: LocalizationHelper.instance.greatWall121bce,
    556: LocalizationHelper.instance.greatWall556ce,
    618: LocalizationHelper.instance.greatWall618ce,
    1487: LocalizationHelper.instance.greatWall1487ce,
  },
);
