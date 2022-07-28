import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/colosseum_search_data.dart';

class ColosseumData extends WonderData {
  ColosseumData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.colosseum,
          title: $strings.colosseumTitle,
          subTitle: $strings.colosseumSubTitle,
          regionTitle: $strings.colosseumRegionTitle,
          videoId: 'GXoEpNjgKzg',
          startYr: 70,
          endYr: 80,
          artifactStartYr: 0,
          artifactEndYr: 500,
          artifactCulture: $strings.colosseumArtifactCulture,
          artifactGeolocation: $strings.colosseumArtifactGeolocation,
          lat: 41.890242126393495,
          lng: 12.492349361871392,
          unsplashCollectionId: 'VPdti8Kjq9o',
          pullQuote1Top: $strings.colosseumPullQuote1Top,
          pullQuote1Bottom: $strings.colosseumPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: $strings.colosseumPullQuote2,
          pullQuote2Author: $strings.colosseumPullQuote2Author,
          callout1: $strings.colosseumCallout1,
          callout2: $strings.colosseumCallout2,
          videoCaption: $strings.colosseumVideoCaption,
          mapCaption: $strings.colosseumMapCaption,
          historyInfo1: $strings.colosseumHistoryInfo1,
          historyInfo2: $strings.colosseumHistoryInfo2,
          constructionInfo1: $strings.colosseumConstructionInfo1,
          constructionInfo2: $strings.colosseumConstructionInfo2,
          locationInfo1: $strings.colosseumLocationInfo1,
          locationInfo2: $strings.colosseumLocationInfo2,
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
            70: $strings.colosseum70ce,
            82: $strings.colosseum82ce,
            1140: $strings.colosseum1140ce,
            1490: $strings.colosseum1490ce,
            1829: $strings.colosseum1829ce,
            1990: $strings.colosseum1990ce,
          },
        );
}
