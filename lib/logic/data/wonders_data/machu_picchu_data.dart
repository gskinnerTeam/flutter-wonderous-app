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
          title: localizationsLogic.instance.machuPicchuTitle,
          subTitle: localizationsLogic.instance.machuPicchuSubTitle,
          regionTitle: localizationsLogic.instance.machuPicchuRegionTitle,
          videoId: 'cnMa-Sm9H4k',
          startYr: 1450,
          endYr: 1572,
          artifactStartYr: 1200,
          artifactEndYr: 1700,
          artifactCulture: localizationsLogic.instance.machuPicchuArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.machuPicchuArtifactGeolocation,
          lat: -13.162690683637758,
          lng: -72.54500778824891,
          unsplashCollectionId: 'wUhgZTyUnl8',
          pullQuote1Top: localizationsLogic.instance.machuPicchuPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.machuPicchuPullQuote1Bottom,
          pullQuote1Author: localizationsLogic.instance.machuPicchuPullQuote1Author,
          pullQuote2: localizationsLogic.instance.machuPicchuPullQuote2,
          pullQuote2Author: localizationsLogic.instance.machuPicchuPullQuote2Author,
          callout1: localizationsLogic.instance.machuPicchuCallout1,
          callout2: localizationsLogic.instance.machuPicchuCallout2,
          videoCaption: localizationsLogic.instance.machuPicchuVideoCaption,
          mapCaption: localizationsLogic.instance.machuPicchuMapCaption,
          historyInfo1: localizationsLogic.instance.machuPicchuHistoryInfo1,
          historyInfo2: localizationsLogic.instance.machuPicchuHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.machuPicchuConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.machuPicchuConstructionInfo2,
          locationInfo1: localizationsLogic.instance.machuPicchuLocationInfo1,
          locationInfo2: localizationsLogic.instance.machuPicchuLocationInfo2,
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
            1438: localizationsLogic.instance.machuPicchu1438ce,
            1572: localizationsLogic.instance.machuPicchu1572ce,
            1867: localizationsLogic.instance.machuPicchu1867ce,
            1911: localizationsLogic.instance.machuPicchu1911ce,
            1964: localizationsLogic.instance.machuPicchu1964ce,
            1997: localizationsLogic.instance.machuPicchu1997ce,
          },
        );
}
