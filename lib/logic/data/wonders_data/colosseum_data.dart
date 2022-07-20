import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/colosseum_search_data.dart';

final colosseumData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.colosseum,
  title: LocalizationHelper.instance.colosseumTitle,
  subTitle: LocalizationHelper.instance.colosseumSubTitle,
  regionTitle: LocalizationHelper.instance.colosseumRegionTitle,
  videoId: 'GXoEpNjgKzg',
  startYr: 70,
  endYr: 80,
  artifactStartYr: 0,
  artifactEndYr: 500,
  artifactCulture: LocalizationHelper.instance.colosseumArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.colosseumArtifactGeolocation,
  lat: 41.890242126393495,
  lng: 12.492349361871392,
  unsplashCollectionId: 'VPdti8Kjq9o',
  pullQuote1Top: LocalizationHelper.instance.colosseumPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.colosseumPullQuote1Bottom,
  pullQuote1Author: '',
  pullQuote2: LocalizationHelper.instance.colosseumPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.colosseumPullQuote2Author,
  callout1: LocalizationHelper.instance.colosseumCallout1,
  callout2: LocalizationHelper.instance.colosseumCallout2,
  videoCaption: LocalizationHelper.instance.colosseumVideoCaption,
  mapCaption: LocalizationHelper.instance.colosseumMapCaption,
  historyInfo1: LocalizationHelper.instance.colosseumHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.colosseumHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.colosseumConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.colosseumConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.colosseumLocationInfo1,
  locationInfo2: LocalizationHelper.instance.colosseumLocationInfo2,
  highlightArtifacts: const [
    '251350',
    '255960',
    '247993',
    '250464',
    '251476',
    '255960',
  ],
  hiddenArtifacts: const [
    '245376',
    '256570',
    '286136',
  ],
  events: {
    70: LocalizationHelper.instance.colosseum70ce,
    82: LocalizationHelper.instance.colosseum82ce,
    1140: LocalizationHelper.instance.colosseum1140ce,
    1490: LocalizationHelper.instance.colosseum1490ce,
    1829: LocalizationHelper.instance.colosseum1829ce,
    1990: LocalizationHelper.instance.colosseum1990ce,
  },
);
