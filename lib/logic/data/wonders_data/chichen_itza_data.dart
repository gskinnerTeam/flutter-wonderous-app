import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/chichen_itza_search_data.dart';

final chichenItzaData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.chichenItza,
  title: LocalizationHelper.instance.chichenItzaTitle,
  subTitle: LocalizationHelper.instance.chichenItzaSubTitle,
  regionTitle: LocalizationHelper.instance.chichenItzaRegionTitle,
  videoId: 'Q6eBJjdca14',
  startYr: 550,
  endYr: 1550,
  artifactStartYr: 500,
  artifactEndYr: 1600,
  artifactCulture: LocalizationHelper.instance.chichenItzaArtifactCulture,
  artifactGeolocation: LocalizationHelper.instance.chichenItzaArtifactGeolocation,
  lat: 20.68346184201756,
  lng: -88.56769676930931,
  unsplashCollectionId: 'SUK0tuMnLLw',
  pullQuote1Top: LocalizationHelper.instance.chichenItzaPullQuote1Top,
  pullQuote1Bottom: LocalizationHelper.instance.chichenItzaPullQuote1Bottom,
  pullQuote1Author: '',
  pullQuote2: LocalizationHelper.instance.chichenItzaPullQuote2,
  pullQuote2Author: LocalizationHelper.instance.chichenItzaPullQuote2Author,
  callout1: LocalizationHelper.instance.chichenItzaCallout1,
  callout2: LocalizationHelper.instance.chichenItzaCallout2,
  videoCaption: LocalizationHelper.instance.chichenItzaVideoCaption,
  mapCaption: LocalizationHelper.instance.chichenItzaMapCaption,
  historyInfo1: LocalizationHelper.instance.chichenItzaHistoryInfo1,
  historyInfo2: LocalizationHelper.instance.chichenItzaHistoryInfo2,
  constructionInfo1: LocalizationHelper.instance.chichenItzaConstructionInfo1,
  constructionInfo2: LocalizationHelper.instance.chichenItzaConstructionInfo2,
  locationInfo1: LocalizationHelper.instance.chichenItzaLocationInfo1,
  locationInfo2: LocalizationHelper.instance.chichenItzaLocationInfo2,
  highlightArtifacts: const [
    '503940',
    '312595',
    '310551',
    '316304',
    '313151',
    '313256',
  ],
  hiddenArtifacts: const [
    '701645',
    '310555',
    '286467',
  ],
  events: {
    600: LocalizationHelper.instance.chichenItza600ce,
    832: LocalizationHelper.instance.chichenItza832ce,
    998: LocalizationHelper.instance.chichenItza998ce,
    1100: LocalizationHelper.instance.chichenItza1100ce,
    1527: LocalizationHelper.instance.chichenItza1527ce,
    1535: LocalizationHelper.instance.chichenItza1535ce,
  },
);
