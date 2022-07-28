import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/chichen_itza_search_data.dart';

class ChichenItzaData extends WonderData {
  ChichenItzaData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.chichenItza,
          title: localizationsLogic.instance.chichenItzaTitle,
          subTitle: localizationsLogic.instance.chichenItzaSubTitle,
          regionTitle: localizationsLogic.instance.chichenItzaRegionTitle,
          videoId: 'Q6eBJjdca14',
          startYr: 550,
          endYr: 1550,
          artifactStartYr: 500,
          artifactEndYr: 1600,
          artifactCulture: localizationsLogic.instance.chichenItzaArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.chichenItzaArtifactGeolocation,
          lat: 20.68346184201756,
          lng: -88.56769676930931,
          unsplashCollectionId: 'SUK0tuMnLLw',
          pullQuote1Top: localizationsLogic.instance.chichenItzaPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.chichenItzaPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: localizationsLogic.instance.chichenItzaPullQuote2,
          pullQuote2Author: localizationsLogic.instance.chichenItzaPullQuote2Author,
          callout1: localizationsLogic.instance.chichenItzaCallout1,
          callout2: localizationsLogic.instance.chichenItzaCallout2,
          videoCaption: localizationsLogic.instance.chichenItzaVideoCaption,
          mapCaption: localizationsLogic.instance.chichenItzaMapCaption,
          historyInfo1: localizationsLogic.instance.chichenItzaHistoryInfo1,
          historyInfo2: localizationsLogic.instance.chichenItzaHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.chichenItzaConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.chichenItzaConstructionInfo2,
          locationInfo1: localizationsLogic.instance.chichenItzaLocationInfo1,
          locationInfo2: localizationsLogic.instance.chichenItzaLocationInfo2,
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
            600: localizationsLogic.instance.chichenItza600ce,
            832: localizationsLogic.instance.chichenItza832ce,
            998: localizationsLogic.instance.chichenItza998ce,
            1100: localizationsLogic.instance.chichenItza1100ce,
            1527: localizationsLogic.instance.chichenItza1527ce,
            1535: localizationsLogic.instance.chichenItza1535ce,
          },
        );
}