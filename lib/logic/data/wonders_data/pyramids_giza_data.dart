import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/pyramids_giza_search_data.dart';

class PyramidsGizaData extends WonderData {
  PyramidsGizaData()
      : super(
          searchData: _searchData, // included as a part from ./search/
          searchSuggestions: _searchSuggestions, // included as a part from ./search/
          type: WonderType.pyramidsGiza,
          title: localizationsLogic.instance.pyramidsGizaTitle,
          subTitle: localizationsLogic.instance.pyramidsGizaSubTitle,
          regionTitle: localizationsLogic.instance.pyramidsGizaRegionTitle,
          videoId: 'lJKX3Y7Vqvs',
          startYr: -2600,
          endYr: -2500,
          artifactStartYr: -2800,
          artifactEndYr: -2300,
          artifactCulture: localizationsLogic.instance.pyramidsGizaArtifactCulture,
          artifactGeolocation: localizationsLogic.instance.pyramidsGizaArtifactGeolocation,
          lat: 29.976111,
          lng: 31.132778,
          unsplashCollectionId: 'CSEvB5Tza9E',
          pullQuote1Top: localizationsLogic.instance.pyramidsGizaPullQuote1Top,
          pullQuote1Bottom: localizationsLogic.instance.pyramidsGizaPullQuote1Bottom,
          pullQuote1Author: '',
          pullQuote2: localizationsLogic.instance.pyramidsGizaPullQuote2,
          pullQuote2Author: localizationsLogic.instance.pyramidsGizaPullQuote2Author,
          callout1: localizationsLogic.instance.pyramidsGizaCallout1,
          callout2: localizationsLogic.instance.pyramidsGizaCallout2,
          videoCaption: localizationsLogic.instance.pyramidsGizaVideoCaption,
          mapCaption: localizationsLogic.instance.pyramidsGizaMapCaption,
          historyInfo1: localizationsLogic.instance.pyramidsGizaHistoryInfo1,
          historyInfo2: localizationsLogic.instance.pyramidsGizaHistoryInfo2,
          constructionInfo1: localizationsLogic.instance.pyramidsGizaConstructionInfo1,
          constructionInfo2: localizationsLogic.instance.pyramidsGizaConstructionInfo2,
          locationInfo1: localizationsLogic.instance.pyramidsGizaLocationInfo1,
          locationInfo2: localizationsLogic.instance.pyramidsGizaLocationInfo2,
          highlightArtifacts: const [
            '543864',
            '546488',
            '557137',
            '543900',
            '543935',
            '544782',
          ],
          hiddenArtifacts: const [
            '546510',
            '543896',
            '545728',
          ],
          events: {
            -2575: localizationsLogic.instance.pyramidsGiza2575bce,
            -2465: localizationsLogic.instance.pyramidsGiza2465bce,
            -443: localizationsLogic.instance.pyramidsGiza443bce,
            1925: localizationsLogic.instance.pyramidsGiza1925ce,
            1979: localizationsLogic.instance.pyramidsGiza1979ce,
            1990: localizationsLogic.instance.pyramidsGiza1990ce,
          },
        );
}
