import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/petra_search_data.dart';

final petraData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.petra,
  title: LocalizationHelper.instance.petraTitle,
  subTitle: LocalizationHelper.instance.petraSubTitle,
  regionTitle: LocalizationHelper.instance.petraRegionTitle,
  videoId: 'ezDiSkOU0wc',
  startYr: -312,
  endYr: 100,
  artifactStartYr: -500,
  artifactEndYr: 500,
  artifactCulture: LocalizationHelper.instance.petraArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.petraArtifactGeolocation,
  lat: 30.328830750209903,
  lng: 35.44398203484667,
  unsplashCollectionId: 'qWQJbDvCMW8',
  pullQuote1Top: LocalizationHelper.instance.petraPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.petraPullQuote1Bottom,
  pullQuote1Author: LocalizationHelper.instance.petraPullQuote1Author,
  pullQuote2: LocalizationHelper.instance.petraPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.petraPullQuote2Author,
  callout1: LocalizationHelper.instance.petraCallout1,
  callout2: LocalizationHelper.instance.petraCallout2,
  videoCaption: LocalizationHelper.instance.petraVideoCaption,
  mapCaption: LocalizationHelper.instance.petraMapCaption,
  historyInfo1: LocalizationHelper.instance.petraHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.petraHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.petraConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.petraConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.petraLocationInfo1,
  locationInfo2: LocalizationHelper.instance.petraLocationInfo2,
  highlightArtifacts: const [
    '325900',
    '325902',
    '325919',
    '325884',
    '325887',
    '325891',
  ],
  hiddenArtifacts: const [
    '322592',
    '325918',
    '326243',
  ],
  events: {
    -1200: LocalizationHelper.instance.petra1200bce,
    -106: LocalizationHelper.instance.petra106bce,
    551: LocalizationHelper.instance.petra551ce,
    1812: LocalizationHelper.instance.petra1812ce,
    1958: LocalizationHelper.instance.petra1958ce,
    1989: LocalizationHelper.instance.petra1989ce,
  },
);
