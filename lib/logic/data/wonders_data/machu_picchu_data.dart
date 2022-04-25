import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/mock_data.dart';

final machuPicchuData = WonderData(
  type: WonderType.machuPicchu,
  title: 'Machu Picchu',
  subTitle: 'Lost City of the Incas',
  regionTitle: 'Cusco Region, Peru',
  videoId: 'cnMa-Sm9H4k',
  startYr: 1450,
  endYr: 1572,
  artifactStartYr: 1400,
  artifactEndYr: 1600,
  artifactCulture: 'Inca',
  artifactGeolocation: 'South America',
  lat: -13.163333,
  lng: -72.545556,
  imageIds: mockImageIds,
  unsplashCollectionId: 'wUhgZTyUnl8',
  quote1: 'Few romances can ever surpass',
  quote2: 'that of the granite citadel',
  quoteAuthor: '',
  historyInfo1:
      '''Construction appears to date from two great Inca rulers, Pachacutec Inca Yupanqui (1438–1471) and Túpac Inca Yupanqui (1472–1493).
''',
  historyInfo2:
      '''There is a consensus among archeologists that Pachacutec ordered the construction of the royal estate for his use as a retreat, most likely after a successful military campaign.
Although Machu Picchu is considered to be a "royal" estate, it would not have been passed down in the line of succession. Rather it was used for 80 years before being abandoned, seemingly because of the Spanish conquests in other parts of the Inca Empire.
''',
  constructionInfo1:
      '''The central buildings use the classical Inca architectural style of polished dry-stone walls of regular shape. The Incas were masters of this technique, called ashlar, in which blocks of stone are cut to fit together tightly without mortar. This precision construction method made the structures at Machu Picchu resistant to seismic activity.
The site itself may have been intentionally built on fault lines to afford better drainage and a ready supply of fractured stone.
''',
  constructionInfo2:
      '''Inca walls have many stabilizing features: doors and windows are trapezoidal, narrowing from bottom to top; corners usually are rounded; inside corners often incline slightly into the rooms, and outside corners were often tied together by "L"-shaped blocks.
''',
  locationInfo:
      '''Machu Picchu is situated above a bow of the Urubamba River, which surrounds the site on three sides, where cliffs drop vertically for 1,480 feet (450 m) to the river at their base. The location of the city was a military secret, and it's deep precipices and steep mountains provided natural defenses.
The Inca Bridge, an Inca grass rope bridge, across the Urubamba River in the Pongo de Mainique, provided a secret entrance for the Inca army. Another Inca bridge was built to the west of Machu Picchu, the tree-trunk bridge, at a location where a gap occurs in the cliff that measures 20 feet (6 m).
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
        'Introduced to the world by Hiram Bingham of Yale University, who was led there by locals after disclosing he was searching for Vilcabamba, the \'lost city of the Incas\'.',
    1964:
        'Surrounding sites were excavated thoroughly by Gene Savoy, who found a much more suitable candidate for Vilcabamba in the ruin known as Espíritu Pampa.',
    1997:
        'Since its rediscovery, growing numbers of tourists have visited the Machu Picchu each year, with numbers exceeding 1.4 million in 2017.',
  },
);
