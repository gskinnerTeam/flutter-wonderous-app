import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/christ_redeemer_search_data.dart';

final christRedeemerData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.christRedeemer,
  title: 'Christ the Redeemer',
  subTitle: 'A symbol of peace',
  regionTitle: 'Rio de Janeiro, Brazil',
  videoId: 'k_615AauSds',
  startYr: 1922,
  endYr: 1931,
  artifactStartYr: 1500,
  artifactEndYr: 2000,
  artifactCulture: '',
  artifactGeolocation: 'Brazil',
  lat: -22.95238891944396,
  lng: -43.21045520611561,
  unsplashCollectionId: 'dPgX5iK8Ufo',
  pullQuote1Top: 'A Perfect Union Between',
  pullQuote1Bottom: 'Nature and Architecture',
  pullQuote1Author: '',
  pullQuote2:
      'The famous statue of Christ the Redeemer that overlooks Rio de Janeiro is only 130 feet tall. McGuintys eco-idols [Wind Turbines] will be three times that height, but will serve the same imposing purpose.',
  pullQuote2Author: 'Ezra Levant',
  callout1: 'The statue of Christ the Redeemer with open arms, a symbol of peace, was chosen.',
  callout2:
      'Construction took nine years, from 1922 to 1931, and cost the equivalent of US\$250,000 (equivalent to \$3,600,000 in 2020) and the monument opened on October 12, 1931.',
  videoCaption: '',
  mapCaption: '',
  historyInfo1:
      '''The placement of a Christian monument on Mount Corcovado was first suggested in the mid-1850s to honor Princess Isabel, regent of Brazil and the daughter of Emperor Pedro II, but the project was not approved.
In 1889 the country became a republic, and owing to the separation of church and state the proposed statue was dismissed.
''',
  historyInfo2:
      '''The Catholic Circle of Rio made a second proposal for a landmark statue on the mountain in 1920. The group organized an event called Semana do Monumento ("Monument Week") to attract donations and collect signatures to support the building of the statue. The organization was motivated by what they perceived as "Godlessness" in the society.
The designs considered for the "Statue of the Christ" included a representation of the Christian cross, a statue of Jesus with a globe in his hands, and a pedestal symbolizing the world.
''',
  constructionInfo1:
      '''Local engineer Heitor da Silva Costa and artist Carlos Oswald designed the statue.[10] French sculptor Paul Landowski created the work. In 1922, Landowski commissioned fellow Parisian Romanian sculptor Gheorghe Leonida, who studied sculpture at the Fine Arts Conservatory in Bucharest and in Italy.
''',
  constructionInfo2:
      '''A group of engineers and technicians studied Landowski's submissions and felt building the structure of reinforced concrete instead of steel was more suitable for the cross-shaped statue. The concrete making up the base was supplied from Limhamn, Sweden. The outer layers are soapstone, chosen for its enduring qualities and ease of use.
''',
  locationInfo:
      '''Corcovado, which means "hunchback" in Portuguese, is a mountain in central Rio de Janeiro, Brazil. It is a 2,329 foot (710 m) granite peak located in the Tijuca Forest, a national park.
Corcovado hill lies just west of the city center but is wholly within the city limits and visible from great distances.
''',
  highlightArtifacts: const [
    '764815',
    '502019',
    '764814',
    '764816',
    '501319',
  ],
  hiddenArtifacts: const [
    '501302',
    '157985',
    '227759',
  ],
  events: const {
    1850:
        'Plans for the statue were first proposed by Pedro Maria Boss upon Mount Corcovado. This was never approved, however.',
    1921:
        'A new plan was proposed by the Roman Catholic archdiocese, and after the citizens of Rio de Janeiro petitioned the president, it was finally approved.',
    1922: 'The foundation of the statue was ceremoniously laid out to commemorate Brazil’s independence from Portugal.',
    1926:
        'Construction officially began after the initial design was chosen via a competition and amended by Brazilian artists and engineers.',
    1931: 'Construction of the statue was completed, standing 98’ tall with a 92’ wide arm span.',
    2006:
        'A chapel was consecrated at the statue’s base to Our Lady of Aparecida to mark the statue’s 75th anniversary.',
  },
);
