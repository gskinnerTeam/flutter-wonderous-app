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
          title: localizationsLogic.instance.greatWallTitle,
          subTitle: localizationsLogic.instance.greatWallSubTitle,
          regionTitle: localizationsLogic.instance.greatWallRegionTitle,
          videoId: 'do1Go22Wu8o',
          startYr: -700,
          endYr: 1644,
          artifactStartYr: -700,
          artifactEndYr: 1650,
          artifactCulture: localizationsLogic.instance.greatWallArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.greatWallArtifactGeolocation,
          lat: 40.43199751120627,
          lng: 116.57040708482984,
          unsplashCollectionId: 'Kg_h04xvZEo',
          pullQuote1Top: localizationsLogic.instance.greatWallPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.greatWallPullQuote1Bottom,
          pullQuote1Author: '', //No key because it doesn't generate for empty values
          pullQuote2: localizationsLogic.instance.greatWallPullQuote2,
          pullQuote2Author: localizationsLogic.instance.greatWallPullQuote2Author,
          callout1: localizationsLogic.instance.greatWallCallout1,
          callout2: localizationsLogic.instance.greatWallCallout2,
          videoCaption: localizationsLogic.instance.greatWallVideoCaption,
          mapCaption: localizationsLogic.instance.greatWallMapCaption,
          historyInfo1: localizationsLogic.instance.greatWallHistoryInfo1,
          historyInfo2: localizationsLogic.instance.greatWallHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.greatWallConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.greatWallConstructionInfo2,
          locationInfo1: localizationsLogic.instance.greatWallLocationInfo1,
          locationInfo2: localizationsLogic.instance.greatWallLocationInfo2,
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
            -700: localizationsLogic.instance.greatWall700bce,
            -214: localizationsLogic.instance.greatWall214bce,
            -121: localizationsLogic.instance.greatWall121bce,
            556: localizationsLogic.instance.greatWall556ce,
            618: localizationsLogic.instance.greatWall618ce,
            1487: localizationsLogic.instance.greatWall1487ce,
          },
        );
}
