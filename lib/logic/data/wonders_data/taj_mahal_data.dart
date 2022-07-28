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
          title: localizationsLogic.instance.tajMahalTitle,
          subTitle: localizationsLogic.instance.tajMahalSubTitle,
          regionTitle: localizationsLogic.instance.tajMahalRegionTitle,
          videoId: 'EWkDzLrhpXI',
          startYr: 1632,
          endYr: 1653,
          artifactStartYr: 1600,
          artifactEndYr: 1700,
          artifactCulture: localizationsLogic.instance.tajMahalArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.tajMahalArtifactGeolocation,
          lat: 27.17405039840427,
          lng: 78.04211890065208,
          unsplashCollectionId: '684IRta86_c',
          pullQuote1Top: localizationsLogic.instance.tajMahalPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.tajMahalPullQuote1Bottom,
          pullQuote1Author: localizationsLogic.instance.tajMahalPullQuote1Author,
          pullQuote2: localizationsLogic.instance.tajMahalPullQuote2,
          pullQuote2Author: localizationsLogic.instance.tajMahalPullQuote2Author,
          callout1: localizationsLogic.instance.tajMahalCallout1,
          callout2: localizationsLogic.instance.tajMahalCallout2,
          videoCaption: localizationsLogic.instance.tajMahalVideoCaption,
          mapCaption: localizationsLogic.instance.tajMahalMapCaption,
          historyInfo1: localizationsLogic.instance.tajMahalHistoryInfo1,
          historyInfo2: localizationsLogic.instance.tajMahalHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.tajMahalConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.tajMahalConstructionInfo2,
          locationInfo1: localizationsLogic.instance.tajMahalLocationInfo1,
          locationInfo2: localizationsLogic.instance.tajMahalLocationInfo2,
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
            1631: localizationsLogic.instance.tajMahal1631ce,
            1647: localizationsLogic.instance.tajMahal1647ce,
            1658: localizationsLogic.instance.tajMahal1658ce,
            1901: localizationsLogic.instance.tajMahal1901ce,
            1984: localizationsLogic.instance.tajMahal1984ce,
            1998: localizationsLogic.instance.tajMahal1998ce,
          },
        );
}
