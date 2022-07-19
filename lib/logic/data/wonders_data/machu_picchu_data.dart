import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/machu_picchu_search_data.dart';

final machuPicchuData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.machuPicchu,
  title: 'Machu Picchu',
  subTitle: 'Citadel of the Inca',
  regionTitle: 'Cusco Region, Peru',
  videoId: 'cnMa-Sm9H4k',
  startYr: 1450,
  endYr: 1572,
  artifactStartYr: 1200,
  artifactEndYr: 1700,
  artifactCulture: 'Inca',
  artifactGeolocation: 'South America',
  lat: -13.162690683637758,
  lng: -72.54500778824891,
  unsplashCollectionId: 'wUhgZTyUnl8',
  pullQuote1Top: 'Few Romances Can Ever Surpass',
  pullQuote1Bottom: 'That of the Granite Citadel',
  pullQuote1Author: 'Hiram Bingham',
  pullQuote2:
      'In the variety of its charms and the power of its spell, I know of no other place in the weld which can compare with it.',
  pullQuote2Author: 'Hiram Bingham',
  callout1:
      'During its use as a royal estate, it is estimated that about 750 people lived there, with most serving as support staff who lived there permanently.',
  callout2:
      'The Incas were masters of this technique, called ashlar, in which blocks of stone are cut to fit together tightly without mortar.',
  videoCaption: '“Machu Picchu 101 | National Geographic.” Youtube, uploaded by National Geographic.',
  mapCaption: 'Map showing location of Machu Picchu in the Eastern Cordillera of southern Peru.',
  historyInfo1:
      '''Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru on a 2,430-meter (7,970 ft) mountain ridge. Construction appears to date from two great Inca rulers, Pachacutec Inca Yupanqui (1438–1471 CE) and Túpac Inca Yupanqui (1472–1493 CE).
''',
  historyInfo2:
      '''There is a consensus among archeologists that Pachacutec ordered the construction of the royal estate for his use as a retreat, most likely after a successful military campaign.
Rather it was used for 80 years before being abandoned, seemingly because of the Spanish conquests in other parts of the Inca Empire.
''',
  constructionInfo1:
      '''The central buildings use the classical Inca architectural style of polished dry-stone walls of regular shape. 
Inca walls have many stabilizing features: doors and windows are trapezoidal, narrowing from bottom to top; corners usually are rounded; inside corners often incline slightly into the rooms, and outside corners were often tied together by "L"-shaped blocks.
''',
  constructionInfo2:
      '''This precision construction method made the structures at Machu Picchu resistant to seismic activity.
The site itself may have been intentionally built on fault lines to afford better drainage and a ready supply of fractured stone.
''',
  locationInfo1:
      '''Machu Picchu is situated above a bow of the Urubamba River, which surrounds the site on three sides, where cliffs drop vertically for 1,480 feet (450 m) to the river at their base. The location of the city was a military secret, and its deep precipices and steep mountains provided natural defenses.
''',
  locationInfo2:
      '''The Inca Bridge, an Inca grass rope bridge, across the Urubamba River in the Pongo de Mainique, provided a secret entrance for the Inca army. Another Inca bridge was built to the west of Machu Picchu, the tree-trunk bridge, at a location where a gap occurs in the cliff that measures 20 feet (6 m).
''',
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
  events: const {
    1438: 'Speculated to be built and occupied by Inca ruler Pachacuti Inca Yupanqui.',
    1572:
        'The last Inca rulers used the site as a bastion to rebel against Spanish rule until they were ultimately wiped out.',
    1867:
        'Speculated to have been originally discovered by German explorer Augusto Berns, but his findings were never effectively publicized.',
    1911:
        'Introduced to the world by Hiram Bingham of Yale University, who was led there by locals after disclosing he was searching for Vilcabamba, the ’lost city of the Incas’.',
    1964:
        'Surrounding sites were excavated thoroughly by Gene Savoy, who found a much more suitable candidate for Vilcabamba in the ruin known as Espíritu Pampa.',
    1997:
        'Since its rediscovery, growing numbers of tourists have visited the Machu Picchu each year, with numbers exceeding 1.4 million in 2017.',
  },
);
