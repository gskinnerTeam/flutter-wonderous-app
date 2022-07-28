import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/great_wall_search_data.dart';

class GreatWallData extends WonderData {
  GreatWallData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.greatWall,
          title: $strings.greatWallTitle,
          subTitle: $strings.greatWallSubTitle,
          regionTitle: $strings.greatWallRegionTitle,
          videoId: 'do1Go22Wu8o',
          startYr: -700,
          endYr: 1644,
          artifactStartYr: -700,
          artifactEndYr: 1650,
          artifactCulture: $strings.greatWallArtifactCulture,
          artifactGeolocation: $strings.greatWallArtifactGeolocation,
          lat: 40.43199751120627,
          lng: 116.57040708482984,
          unsplashCollectionId: 'Kg_h04xvZEo',
          pullQuote1Top: $strings.greatWallPullQuote1Top,
          pullQuote1Bottom: $strings.greatWallPullQuote1Bottom,
          pullQuote1Author: '', //No key because it doesn't generate for empty values
          pullQuote2: $strings.greatWallPullQuote2,
          pullQuote2Author: $strings.greatWallPullQuote2Author,
          callout1: $strings.greatWallCallout1,
          callout2: $strings.greatWallCallout2,
          videoCaption: $strings.greatWallVideoCaption,
          mapCaption: $strings.greatWallMapCaption,
          historyInfo1: $strings.greatWallHistoryInfo1,
          historyInfo2: $strings.greatWallHistoryInfo2,
          constructionInfo1: $strings.greatWallConstructionInfo1,
          constructionInfo2: $strings.greatWallConstructionInfo2,
          locationInfo1: $strings.greatWallLocationInfo1,
          locationInfo2: $strings.greatWallLocationInfo2,
          highlightArtifacts: const [
            '79091',
            '781812',
            '40213',
            '40765',
            '57612',
            '666573',
          ],
          hiddenArtifacts: const [
            '39918',
            '39666',
            '39735',
          ],
          events: {
            -700: $strings.greatWall700bce,
            -214: $strings.greatWall214bce,
            -121: $strings.greatWall121bce,
            556: $strings.greatWall556ce,
            618: $strings.greatWall618ce,
            1487: $strings.greatWall1487ce,
          },
        );
}
