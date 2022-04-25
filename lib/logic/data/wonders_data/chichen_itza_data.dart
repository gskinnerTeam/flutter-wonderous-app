import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/mock_data.dart';

final chichenItzaData = WonderData(
  type: WonderType.chichenItza,
  title: 'Chichen Itza',
  subTitle: 'The Great Mayan City',
  regionTitle: 'Yucatan, Mexico',
  videoId: 'Q6eBJjdca14',
  startYr: 550,
  endYr: 1550,
  artifactStartYr: -500,
  artifactEndYr: 1600,
  artifactCulture: 'Maya',
  artifactGeolocation: 'North and Central America',
  lat: -88.56769676930931,
  lng: 20.68346184201756,
  imageIds: mockImageIds,
  unsplashCollectionId: 'SUK0tuMnLLw',
  quote1: 'The Beauty Between',
  quote2: 'the Heaven\nand the\nUnderworld',
  quoteAuthor: '',
  historyInfo1:
      '''Chichén Itzá is a large Mayan city famous for a large, pyramid temple built by the Maya civilization. It was likely to have been one of the mythical great cities, or Tollans, referred to in later Mesoamerican literature.
The earliest hieroglyphic date discovered at Chichen Itza is equivalent to 832 AD, while the last known date was recorded in the Osario temple in 998.
''',
  historyInfo2:
      '''The site exhibits a multitude of architectural styles, reminiscent of styles seen in central Mexico and of the Puuc and Chenes styles of the Northern Maya lowlands.
Chichen Itza is one of the most visited archeological sites in Mexico with over 2.6 million tourists in 2017.
''',
  constructionInfo1:
      '''Chichen Itza was built upon broken terrain, which was artificially leveled in order to build the major architectural groups, with the greatest effort being expended in the leveling of the areas for the Castillo pyramid, and the Las Monjas, Osario and Main Southwest groups.
''',
  constructionInfo2:
      '''Dominating the North Platform of Chichen Itza is the Temple of Kukulcán. The temple was identified by the first Spaniards to see it, as El Castillo ("the castle"), and it regularly is referred to as such. This step pyramid stands about 30 meters (98 ft) high and consists of a series of nine square terraces, each approximately 2.57 meters (8.4 ft) high, with a 6-meter (20 ft) high temple upon the summit.
''',
  locationInfo:
      '''Chichen Itza is located in the eastern portion of Yucatán state in Mexico. The northern Yucatán Peninsula is karst, and the rivers in the interior all run underground. 
There are four visible, natural sinkholes, called cenotes, that could have provided plentiful water year round at Chichen, making it attractive for settlement.
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
