import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/great_wall_search_data.dart';

final greatWallData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.greatWall,
  title: 'The Great Wall',
  subTitle: 'Longest structure on Earth',
  regionTitle: 'China',
  videoId: 'do1Go22Wu8o',
  startYr: -700,
  endYr: 1644,
  artifactStartYr: -700,
  artifactEndYr: 1650,
  artifactCulture: 'Chinese',
  artifactGeolocation: 'China',
  lat: 40.43199751120627,
  lng: 116.57040708482984,
  unsplashCollectionId: 'Kg_h04xvZEo',
  quote1: 'One of the most impressive',
  quote2: 'architectural feats in history',
  quoteAuthor: '',
  historyInfo1:
      '''The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. The total length of all sections ever built is over 13,000 miles.
''',
  historyInfo2:
      '''Several walls were built from as early as the 7th century BCE, with selective stretches later joined together by Qin Shi Huang (220–206  BCE), the first emperor of China. Little of the Qin wall remains.
Later on, many successive dynasties built and maintained multiple stretches of border walls. The best-known sections of the wall were built by the Ming dynasty (1368–1644).
''',
  constructionInfo1:
      '''In early wall construction transporting the large quantity of materials required for construction was difficult, so builders always tried to use local resources. Stones from the mountains were used over mountain ranges, while rammed earth was used for construction in the plains. Most of the ancient walls have eroded away over the centuries.
''',
  constructionInfo2:
      '''During the Ming dynasty, however, bricks were heavily used in many areas of the wall, as were materials such as tiles, lime, and stone. Stones cut into rectangular shapes were used for the foundation, inner and outer brims, and gateways of the wall. 
Under the rule of the Qing dynasty, China's borders extended beyond the walls and Mongolia was annexed into the empire, so construction was discontinued.
''',
  locationInfo:
      '''The frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino–Russian border in the north to Tao River in the south; along an arc that roughly delineates the edge of the Mongolian steppe.
Apart from defense, other purposes of the Great Wall have included border controls, allowing the imposition of duties on goods transported along the Silk Road, regulation or encouragement of trade and the control of immigration and emigration.
''',
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
  events: const {
    -700:
        'First landmark of the Great Wall began originally as a square wall surrounding the state of Chu. Over the years, additional walls would be built and added to it to expand and connect territory.',
    -214:
        'The first Qin Emperor unifies China and links the wall of the surrounding states of Qin, Yan, and Zhao into the Great Wall of China, taking 10 years to build with hundreds of thousands of laborers.',
    -121:
        'A 20-year construction project was started by the Han emperor to build east and west sections of the wall, including beacons, towers, and castles. Not just for defense, but also to control trade routes like the Silk Road.',
    556:
        'The Bei Qi kingdom also launched several construction projects, utilizing over 1.8 million workers to repair and extend sections of the wall, adding to its length and even building a second inner wall around Shanxi.',
    618:
        'The Great Wall was repaired during the Sui Dynasty and used to defend against Tujue attacks. Before and after the Sui Dynasty, the wall saw very little use and fell into disrepair.',
    1487:
        'Hongzhi Emperor split the walls into north and south lines, eventually shaping it into how it is today. Since then, it has gradually fallen into disrepair and remains mostly unused.',
  },
);
