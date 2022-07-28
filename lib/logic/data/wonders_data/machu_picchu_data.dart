import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/machu_picchu_search_data.dart';

class MachuPicchuData extends WonderData {
  MachuPicchuData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.machuPicchu,
          title: $strings.machuPicchuTitle,
          subTitle: $strings.machuPicchuSubTitle,
          regionTitle: $strings.machuPicchuRegionTitle,
          videoId: 'cnMa-Sm9H4k',
          startYr: 1450,
          endYr: 1572,
          artifactStartYr: 1200,
          artifactEndYr: 1700,
          artifactCulture: $strings.machuPicchuArtifactCulture,
          artifactGeolocation: $strings.machuPicchuArtifactGeolocation,
          lat: -13.162690683637758,
          lng: -72.54500778824891,
          unsplashCollectionId: 'wUhgZTyUnl8',
          pullQuote1Top: $strings.machuPicchuPullQuote1Top,
          pullQuote1Bottom: $strings.machuPicchuPullQuote1Bottom,
          pullQuote1Author: $strings.machuPicchuPullQuote1Author,
          pullQuote2: $strings.machuPicchuPullQuote2,
          pullQuote2Author: $strings.machuPicchuPullQuote2Author,
          callout1: $strings.machuPicchuCallout1,
          callout2: $strings.machuPicchuCallout2,
          videoCaption: $strings.machuPicchuVideoCaption,
          mapCaption: $strings.machuPicchuMapCaption,
          historyInfo1: $strings.machuPicchuHistoryInfo1,
          historyInfo2: $strings.machuPicchuHistoryInfo2,
          constructionInfo1: $strings.machuPicchuConstructionInfo1,
          constructionInfo2: $strings.machuPicchuConstructionInfo2,
          locationInfo1: $strings.machuPicchuLocationInfo1,
          locationInfo2: $strings.machuPicchuLocationInfo2,
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
            1438: $strings.machuPicchu1438ce,
            1572: $strings.machuPicchu1572ce,
            1867: $strings.machuPicchu1867ce,
            1911: $strings.machuPicchu1911ce,
            1964: $strings.machuPicchu1964ce,
            1997: $strings.machuPicchu1997ce,
          },
        );
}
