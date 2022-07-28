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
          title: $strings.christRedeemerTitle,
          subTitle: $strings.christRedeemerSubTitle,
          regionTitle: $strings.christRedeemerRegionTitle,
          videoId: 'k_615AauSds',
          startYr: 1922,
          endYr: 1931,
          artifactStartYr: 1600,
          artifactEndYr: 2100,
          artifactCulture: '',
          artifactGeolocation: $strings.christRedeemerArtifactGeolocation,
          lat: -22.95238891944396,
          lng: -43.21045520611561,
          unsplashCollectionId: 'dPgX5iK8Ufo',
          pullQuote1Top: $strings.christRedeemerPullQuote1Top,
          pullQuote1Bottom: $strings.christRedeemerPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: $strings.christRedeemerPullQuote2,
          pullQuote2Author: $strings.christRedeemerPullQuote2Author,
          callout1: $strings.christRedeemerCallout1,
          callout2: $strings.christRedeemerCallout2,
          videoCaption: $strings.christRedeemerVideoCaption,
          mapCaption: $strings.christRedeemerMapCaption,
          historyInfo1: $strings.christRedeemerHistoryInfo1,
          historyInfo2: $strings.christRedeemerHistoryInfo2,
          constructionInfo1: $strings.christRedeemerConstructionInfo1,
          constructionInfo2: $strings.christRedeemerConstructionInfo2,
          locationInfo1: $strings.christRedeemerLocationInfo1,
          locationInfo2: $strings.christRedeemerLocationInfo2,
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
            1850: $strings.christRedeemer1850ce,
            1921: $strings.christRedeemer1921ce,
            1922: $strings.christRedeemer1922ce,
            1926: $strings.christRedeemer1926ce,
            1931: $strings.christRedeemer1931ce,
            2006: $strings.christRedeemer2006ce,
          },
        );
}
