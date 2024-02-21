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
          title: $strings.chichenItzaTitle,
          subTitle: $strings.chichenItzaSubTitle,
          regionTitle: $strings.chichenItzaRegionTitle,
          videoId: 'Q6eBJjdca14',
          startYr: 550,
          endYr: 1550,
          artifactStartYr: 500,
          artifactEndYr: 1600,
          artifactCulture: $strings.chichenItzaArtifactCulture,
          artifactGeolocation: $strings.chichenItzaArtifactGeolocation,
          lat: 20.68346184201756,
          lng: -88.56769676930931,
          unsplashCollectionId: 'SUK0tuMnLLw',
          pullQuote1Top: $strings.chichenItzaPullQuote1Top,
          pullQuote1Bottom: $strings.chichenItzaPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: $strings.chichenItzaPullQuote2,
          pullQuote2Author: $strings.chichenItzaPullQuote2Author,
          callout1: $strings.chichenItzaCallout1,
          callout2: $strings.chichenItzaCallout2,
          videoCaption: $strings.chichenItzaVideoCaption,
          mapCaption: $strings.chichenItzaMapCaption,
          historyInfo1: $strings.chichenItzaHistoryInfo1,
          historyInfo2: $strings.chichenItzaHistoryInfo2,
          constructionInfo1: $strings.chichenItzaConstructionInfo1,
          constructionInfo2: $strings.chichenItzaConstructionInfo2,
          locationInfo1: $strings.chichenItzaLocationInfo1,
          locationInfo2: $strings.chichenItzaLocationInfo2,
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
            600: $strings.chichenItza600ce,
            832: $strings.chichenItza832ce,
            998: $strings.chichenItza998ce,
            1100: $strings.chichenItza1100ce,
            1527: $strings.chichenItza1527ce,
            1535: $strings.chichenItza1535ce,
          },
        );
}
