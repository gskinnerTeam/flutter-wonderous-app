import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/taj_mahal_search_data.dart';

final tajMahalData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.tajMahal,
  title: LocalizationHelper.instance.tajMahalTitle,
  subTitle: LocalizationHelper.instance.tajMahalSubTitle,
  regionTitle: LocalizationHelper.instance.tajMahalRegionTitle,
  videoId: 'EWkDzLrhpXI',
  startYr: 1632,
  endYr: 1653,
  artifactStartYr: 1600,
  artifactEndYr: 1700,
  artifactCulture: LocalizationHelper.instance.tajMahalArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.tajMahalArtifactGeolocation,
  lat: 27.17405039840427,
  lng: 78.04211890065208,
  unsplashCollectionId: '684IRta86_c',
  pullQuote1Top: LocalizationHelper.instance.tajMahalPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.tajMahalPullQuote1Bottom,
  pullQuote1Author: LocalizationHelper.instance.tajMahalPullQuote1Author,
  pullQuote2: LocalizationHelper.instance.tajMahalPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.tajMahalPullQuote2Author,
  callout1: LocalizationHelper.instance.tajMahalCallout1,
  callout2: LocalizationHelper.instance.tajMahalCallout2,
  videoCaption: LocalizationHelper.instance.tajMahalVideoCaption,
  mapCaption: LocalizationHelper.instance.tajMahalMapCaption,
  historyInfo1: LocalizationHelper.instance.tajMahalHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.tajMahalHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.tajMahalConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.tajMahalConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.tajMahalLocationInfo1,
  locationInfo2: LocalizationHelper.instance.tajMahalLocationInfo2,
  highlightArtifacts: const [
    '453341',
    '453243',
    '73309',
    '24932',
    '56230',
    '35633',
  ],
  hiddenArtifacts: const [
    '24907',
    '453183',
    '453983',
  ],
  events: {
    1631: LocalizationHelper.instance.tajMahal1631ce,
    1647: LocalizationHelper.instance.tajMahal1647ce,
    1658: LocalizationHelper.instance.tajMahal1658ce,
    1901: LocalizationHelper.instance.tajMahal1901ce,
    1984: LocalizationHelper.instance.tajMahal1984ce,
    1998: LocalizationHelper.instance.tajMahal1998ce,
  },
);
