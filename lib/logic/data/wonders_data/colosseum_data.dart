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
          title: localizationsLogic.instance.colosseumTitle,
          subTitle: localizationsLogic.instance.colosseumSubTitle,
          regionTitle: localizationsLogic.instance.colosseumRegionTitle,
          videoId: 'GXoEpNjgKzg',
          startYr: 70,
          endYr: 80,
          artifactStartYr: 0,
          artifactEndYr: 500,
          artifactCulture: localizationsLogic.instance.colosseumArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.colosseumArtifactGeolocation,
          lat: 41.890242126393495,
          lng: 12.492349361871392,
          unsplashCollectionId: 'VPdti8Kjq9o',
          pullQuote1Top: localizationsLogic.instance.colosseumPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.colosseumPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: localizationsLogic.instance.colosseumPullQuote2,
          pullQuote2Author: localizationsLogic.instance.colosseumPullQuote2Author,
          callout1: localizationsLogic.instance.colosseumCallout1,
          callout2: localizationsLogic.instance.colosseumCallout2,
          videoCaption: localizationsLogic.instance.colosseumVideoCaption,
          mapCaption: localizationsLogic.instance.colosseumMapCaption,
          historyInfo1: localizationsLogic.instance.colosseumHistoryInfo1,
          historyInfo2: localizationsLogic.instance.colosseumHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.colosseumConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.colosseumConstructionInfo2,
          locationInfo1: localizationsLogic.instance.colosseumLocationInfo1,
          locationInfo2: localizationsLogic.instance.colosseumLocationInfo2,
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
            70: localizationsLogic.instance.colosseum70ce,
            82: localizationsLogic.instance.colosseum82ce,
            1140: localizationsLogic.instance.colosseum1140ce,
            1490: localizationsLogic.instance.colosseum1490ce,
            1829: localizationsLogic.instance.colosseum1829ce,
            1990: localizationsLogic.instance.colosseum1990ce,
          },
        );
}
