import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/pyramids_giza_search_data.dart';

final pyramidsGizaData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.pyramidsGiza,
  title: 'Pyramids of Giza',
  subTitle: 'The ancient wonder',
  regionTitle: 'Cairo, Egypt',
  videoId: 'lJKX3Y7Vqvs',
  startYr: -2600,
  endYr: -2500,
  artifactStartYr: -2600,
  artifactEndYr: -2500,
  artifactCulture: 'Egyptian',
  artifactGeolocation: 'Egypt',
  lat: 29.976111,
  lng: 31.132778,
  unsplashCollectionId: 'CSEvB5Tza9E',
  quote1: 'The tallest structures on earth',
  quote2: 'until the advent of modern skyscrapers',
  quoteAuthor: '',
  historyInfo1:
      '''The Giza pyramid complex, also called the Giza necropolis, is the site on the Giza Plateau in Greater Cairo, Egypt that includes the Great Pyramid of Giza, the Pyramid of Khafre, and the Pyramid of Menkaure, along with their associated pyramid complexes and the Great Sphinx of Giza. All were built during the Fourth Dynasty of the Old Kingdom of Ancient Egypt, between 2600 and 2500 BCE.
''',
  historyInfo2:
      '''The pyramids of Giza and others are thought to have been constructed to house the remains of the deceased pharaohs who ruled over Ancient Egypt. A portion of the pharaoh's spirit called his ka was believed to remain with his corpse. Proper care of the remains was necessary in order for the former Pharaoh to perform his new duties as king of the dead.
It is theorized the pyramid not only served as a tomb for the pharaoh, but also as a storage pit for various items he would need in the afterlife.
''',
  constructionInfo1:
      '''Most construction theories are based on the idea that the pyramids were built by moving huge stones from a quarry and dragging and lifting them into place. In building the pyramids, the architects might have developed their techniques over time.
They would select a site on a relatively flat area of bedrock—not sand—which provided a stable foundation. After carefully surveying the site and laying down the first level of stones, they constructed the pyramids in horizontal levels, one on top of the other.
''',
  constructionInfo2:
      '''For the Great Pyramid, most of the stone for the interior seems to have been quarried immediately to the south of the construction site. The smooth exterior of the pyramid was made of a fine grade of white limestone that was quarried across the Nile.
To ensure that the pyramid remained symmetrical, the exterior casing stones all had to be equal in height and width. Workers might have marked all the blocks to indicate the angle of the pyramid wall and trimmed the surfaces carefully so that the blocks fit together. During construction, the outer surface of the stone was smooth limestone; excess stone has eroded as time has passed.
''',
  locationInfo:
      '''The site is at the edges of the Western Desert, approximately 5.6 miles (9 km) west of the Nile River in the city of Giza, and about 8 miles (13 km) southwest of the city center of Cairo.
''',
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
  events: const {
    -2575: 'Construction of the 3 pyramids began for three kings of the 4th dynasty; Khufu, Khafre, and Menkaure.',
    -2465:
        'Construction began on the smaller surrounding structures called Mastabas for royalty of the 5th and 6th dynasties.',
    -443:
        'Greek Author Herodotus speculated that the pyramids were built in the span of 20 years with over 100,000 slave labourers. This assumption would last for over 1500 years',
    1925:
        'Tomb of Queen Hetepheres was discovered, containing furniture and jewelry. One of the last remaining treasure-filled tombs after many years of looting and plundering.',
    1979: 'Designated a UNESCO World Heritage Site to prevent any more unauthorized plundering and vandalism.',
    1990:
        'Discovery of labouror\'s districts suggest that the workers building the pyramids were not slaves, and an ingenious building method proved a relatively small work-force was required to build such immense structures.',
  },
);
