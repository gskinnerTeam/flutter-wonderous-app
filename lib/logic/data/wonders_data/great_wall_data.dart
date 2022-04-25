import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/mock_data.dart';

final greatWallData = WonderData(
  type: WonderType.greatWall,
  title: 'The Great Wall of China',
  subTitle: 'The longest man-made structure on Earth',
  regionTitle: 'China',
  videoId: 'do1Go22Wu8o',
  startYr: -700,
  endYr: 1644,
  artifactStartYr: 1350,
  artifactEndYr: 1650,
  artifactCulture: 'Chinese',
  artifactGeolocation: 'China',
  lat: 40.68,
  lng: 117.23,
  imageIds: mockImageIds,
  unsplashCollectionId: 'Kg_h04xvZEo',
  quote1: 'Time is the test of greatness',
  quote2: 'The First Emperor built the Great Wall',
  quoteAuthor: '',
  historyInfo1:
      '''The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. The total length of all sections ever built is over 13,000 miles.
''',
  historyInfo2:
      '''Several walls were built from as early as the 7th century BC, with selective stretches later joined together by Qin Shi Huang (220-206 BC), the first emperor of China. Little of the Qin wall remains.
Later on, many successive dynasties built and maintained multiple stretches of border walls. The best-known sections of the wall were built by the Ming dynasty (1368-1644).
''',
  constructionInfo1:
      '''Before the use of bricks, the Great Wall was mainly built from rammed earth, stones, and wood. During the Ming, however, bricks were heavily used in many areas of the wall, as were materials such as tiles, lime, and stone.
''',
  constructionInfo2:
      '''The size and weight of the bricks made them easier to work with than earth and stone, so construction quickened. Stones cut into rectangular shapes were used for the foundation, inner and outer brims, and gateways of the wall. 
Today, the defensive system of the Great Wall is generally recognized as one of the most impressive architectural feats in history.
''',
  locationInfo:
      '''The frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino-Russian border in the north to Tao River in the south; along an arc that roughly delineates the edge of the Mongolian steppe.
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
