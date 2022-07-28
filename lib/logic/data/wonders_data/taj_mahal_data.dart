import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/taj_mahal_search_data.dart';

class TajMahalData extends WonderData {
  TajMahalData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.tajMahal,
          title: $strings.tajMahalTitle,
          subTitle: $strings.tajMahalSubTitle,
          regionTitle: $strings.tajMahalRegionTitle,
          videoId: 'EWkDzLrhpXI',
          startYr: 1632,
          endYr: 1653,
          artifactStartYr: 1600,
          artifactEndYr: 1700,
          artifactCulture: $strings.tajMahalArtifactCulture,
          artifactGeolocation: $strings.tajMahalArtifactGeolocation,
          lat: 27.17405039840427,
          lng: 78.04211890065208,
          unsplashCollectionId: '684IRta86_c',
          pullQuote1Top: $strings.tajMahalPullQuote1Top,
          pullQuote1Bottom: $strings.tajMahalPullQuote1Bottom,
          pullQuote1Author: $strings.tajMahalPullQuote1Author,
          pullQuote2: $strings.tajMahalPullQuote2,
          pullQuote2Author: $strings.tajMahalPullQuote2Author,
          callout1: $strings.tajMahalCallout1,
          callout2: $strings.tajMahalCallout2,
          videoCaption: $strings.tajMahalVideoCaption,
          mapCaption: $strings.tajMahalMapCaption,
          historyInfo1: $strings.tajMahalHistoryInfo1,
          historyInfo2: $strings.tajMahalHistoryInfo2,
          constructionInfo1: $strings.tajMahalConstructionInfo1,
          constructionInfo2: $strings.tajMahalConstructionInfo2,
          locationInfo1: $strings.tajMahalLocationInfo1,
          locationInfo2: $strings.tajMahalLocationInfo2,
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
            1631: $strings.tajMahal1631ce,
            1647: $strings.tajMahal1647ce,
            1658: $strings.tajMahal1658ce,
            1901: $strings.tajMahal1901ce,
            1984: $strings.tajMahal1984ce,
            1998: $strings.tajMahal1998ce,
          },
        );
}
