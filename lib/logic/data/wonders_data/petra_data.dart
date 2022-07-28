import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/petra_search_data.dart';

class PetraData extends WonderData {
  PetraData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.petra,
          title: localizationsLogic.instance.petraTitle,
          subTitle: localizationsLogic.instance.petraSubTitle,
          regionTitle: localizationsLogic.instance.petraRegionTitle,
          videoId: 'ezDiSkOU0wc',
          startYr: -312,
          endYr: 100,
          artifactStartYr: -500,
          artifactEndYr: 500,
          artifactCulture: localizationsLogic.instance.petraArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.petraArtifactGeolocation,
          lat: 30.328830750209903,
          lng: 35.44398203484667,
          unsplashCollectionId: 'qWQJbDvCMW8',
          pullQuote1Top: localizationsLogic.instance.petraPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.petraPullQuote1Bottom,
          pullQuote1Author: localizationsLogic.instance.petraPullQuote1Author,
          pullQuote2: localizationsLogic.instance.petraPullQuote2,
          pullQuote2Author: localizationsLogic.instance.petraPullQuote2Author,
          callout1: localizationsLogic.instance.petraCallout1,
          callout2: localizationsLogic.instance.petraCallout2,
          videoCaption: localizationsLogic.instance.petraVideoCaption,
          mapCaption: localizationsLogic.instance.petraMapCaption,
          historyInfo1: localizationsLogic.instance.petraHistoryInfo1,
          historyInfo2: localizationsLogic.instance.petraHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.petraConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.petraConstructionInfo2,
          locationInfo1: localizationsLogic.instance.petraLocationInfo1,
          locationInfo2: localizationsLogic.instance.petraLocationInfo2,
          highlightArtifacts: const [
            '325900',
            '325902',
            '325919',
            '325884',
            '325887',
            '325891',
          ],
          hiddenArtifacts: const [
            '322592',
            '325918',
            '326243',
          ],
          events: {
            -1200: localizationsLogic.instance.petra1200bce,
            -106: localizationsLogic.instance.petra106bce,
            551: localizationsLogic.instance.petra551ce,
            1812: localizationsLogic.instance.petra1812ce,
            1958: localizationsLogic.instance.petra1958ce,
            1989: localizationsLogic.instance.petra1989ce,
          },
        );
}
