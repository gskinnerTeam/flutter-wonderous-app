import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/christ_redeemer_search_data.dart';

class ChristRedeemerData extends WonderData {
  ChristRedeemerData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.christRedeemer,
          title: localizationsLogic.instance.christRedeemerTitle,
          subTitle: localizationsLogic.instance.christRedeemerSubTitle,
          regionTitle: localizationsLogic.instance.christRedeemerRegionTitle,
          videoId: 'k_615AauSds',
          startYr: 1922,
          endYr: 1931,
          artifactStartYr: 1600,
          artifactEndYr: 2100,
          artifactCulture: '',
          artifactGeolocation: localizationsLogic.instance.christRedeemerArtifactGeolocation,
          lat: -22.95238891944396,
          lng: -43.21045520611561,
          unsplashCollectionId: 'dPgX5iK8Ufo',
          pullQuote1Top: localizationsLogic.instance.christRedeemerPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.christRedeemerPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: localizationsLogic.instance.christRedeemerPullQuote2,
          pullQuote2Author: localizationsLogic.instance.christRedeemerPullQuote2Author,
          callout1: localizationsLogic.instance.christRedeemerCallout1,
          callout2: localizationsLogic.instance.christRedeemerCallout2,
          videoCaption: localizationsLogic.instance.christRedeemerVideoCaption,
          mapCaption: localizationsLogic.instance.christRedeemerMapCaption,
          historyInfo1: localizationsLogic.instance.christRedeemerHistoryInfo1,
          historyInfo2: localizationsLogic.instance.christRedeemerHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.christRedeemerConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.christRedeemerConstructionInfo2,
          locationInfo1: localizationsLogic.instance.christRedeemerLocationInfo1,
          locationInfo2: localizationsLogic.instance.christRedeemerLocationInfo2,
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
            1850: localizationsLogic.instance.christRedeemer1850ce,
            1921: localizationsLogic.instance.christRedeemer1921ce,
            1922: localizationsLogic.instance.christRedeemer1922ce,
            1926: localizationsLogic.instance.christRedeemer1926ce,
            1931: localizationsLogic.instance.christRedeemer1931ce,
            2006: localizationsLogic.instance.christRedeemer2006ce,
          },
        );
}
