import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/chichen_itza_search_data.dart';

final chichenItzaData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.chichenItza,
  title: 'Chichen Itza',
  subTitle: 'The Great Mayan City',
  regionTitle: 'Yucatan, Mexico',
  videoId: 'Q6eBJjdca14',
  startYr: 550,
  endYr: 1550,
  artifactStartYr: 500,
  artifactEndYr: 1600,
  artifactCulture: 'Maya',
  artifactGeolocation: 'North and Central America',
  lat: 20.68346184201756,
  lng: -88.56769676930931,
  unsplashCollectionId: 'SUK0tuMnLLw',
  pullQuote1Top: 'The Beauty Between',
  pullQuote1Bottom: 'the Heavens and the Underworld',
  pullQuote1Author: '',
  pullQuote2:
      'The Maya and Toltec vision of the world and the universe is revealed in their stone monuments and artistic works.',
  pullQuote2Author: 'UNESCO',
  callout1:
      'The site exhibits a multitude of architectural styles, reminiscent of styles seen in central Mexico and of the Puuc and Chenes styles of the Northern Maya lowlands.',
  callout2: 'The city comprised an area of at least 1.9 sq miles (5 sq km) of densely clustered architecture.',
  videoCaption: '“Ancient Maya 101 | National Geographic.” Youtube, uploaded by National Geographic.',
  mapCaption: 'Map showing location of Chichen Itza in Yucatán State, Mexico.',
  historyInfo1:
      '''Chichen Itza was a powerful regional capital controlling north and central Yucatán. The earliest hieroglyphic date discovered at Chichen Itza is equivalent to 832 CE, while the last known date was recorded in the Osario temple in 998 CE.
Dominating the North Platform of Chichen Itza is the famous Temple of Kukulcán. The temple was identified by the first Spaniards to see it, as El Castillo ("the castle"), and it regularly is referred to as such. The temple was identified by the first Spaniards to see it, as El Castillo ("the castle"), and it regularly is referred to as such.
''',
  historyInfo2:
      '''The city was thought to have the most diverse population in the Maya world, a factor that could have contributed to this architectural variety.
''',
  constructionInfo1:
      '''The structures of Chichen Itza were built from precisely chiseled limestone blocks that fit together perfectly without the mortar. Many of these stone buildings were originally painted in red, green, blue and purple colors depending on the availability of the pigments.
The stepped pyramid El Castillo stands about 98 feet (30 m) high and consists of a series of nine square terraces, each approximately 8.4 feet (2.57 m) high, with a 20 foot (6 m) high temple upon the summit.
''',
  constructionInfo2:
      '''It was built upon broken terrain, which was artificially leveled to support structures such as the Castillo pyramid. Important buildings within the center were connected by a dense network of paved roads called sacbeob.
''',
  locationInfo1:
      '''Chichen Itza is located in the eastern portion of Yucatán state in Mexico. Nearby, four large sinkholes, called cenotes, could have provided plentiful water year round at Chichen, making it attractive for settlement.
''',
  locationInfo2:
      '''Of these cenotes, the "Cenote Sagrado" or Sacred Cenote, was used for the sacrifice of precious objects and human beings as a form of worship to the Maya rain god Chaac.
''',
  highlightArtifacts: const [
    '503940',
    '312595',
    '310551',
    '316304',
    '313151',
    '313256',
  ],
  hiddenArtifacts: const [
    '701645',
    '310555',
    '286467',
  ],
  events: const {
    600: 'Chichen Itza rises to regional prominence toward the end of the Early Classic period',
    832: 'The earliest hieroglyphic date discovered at Chichen Itza',
    998: 'Last known date recorded in the Osario temple',
    1100: 'Chichen Itza declines as a regional center',
    1527: 'Invaded by Spanish Conquistador Francisco de Montejo',
    1535: 'All Spanish are driven from the Yucatán Peninsula'
  },
);
