import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/petra_search_data.dart';

final petraData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.petra,
  title: 'Petra',
  subTitle: 'The Lost City',
  regionTitle: 'Ma’an, Jordan',
  videoId: 'ezDiSkOU0wc',
  startYr: -312,
  endYr: 100,
  artifactStartYr: -500,
  artifactEndYr: 500,
  artifactCulture: 'Nabataean',
  artifactGeolocation: 'Levant',
  lat: 30.328830750209903,
  lng: 35.44398203484667,
  unsplashCollectionId: 'qWQJbDvCMW8',
  quote1: 'A rose-red city',
  quote2: 'half as old as Time',
  quoteAuthor: 'John William Burgon',
  historyInfo1:
      '''The area around Petra has been inhabited from as early as 7000  BCE, and the Nabataeans might have settled in what would become the capital city of their kingdom as early as the 4th century  BCE
The trading business gained the Nabataeans considerable revenue and Petra became the focus of their wealth. They were particularly skillful in harvesting rainwater, agriculture and stone carving. 
''',
  historyInfo2:
      '''Petra flourished in the 1st century CE, when its famous Al-Khazneh structure – believed to be the mausoleum of Nabataean king Aretas IV – was constructed, and its population peaked at an estimated 20,000 inhabitants.
Access to the city is through a 3⁄4 mile-long (1.2 km) gorge called the Siq, which leads directly to the Khazneh.
''',
  constructionInfo1:
      '''Famous for its rock-cut architecture and water conduit system, Petra is also called the "Red Rose City" because of the color of the stone from which it is carved.
Another thing Petra is known for is its Hellenistic (“Greek”) architecture. These influences can be seen in many of the facades at Petra and are a reflection of the cultures that the Nabataens traded with.
Perhaps a more prominent resemblance to Hellenistic style in Petra comes with its Treasury, which is 7.8 feet (24 m) wide and 121.3 feet (37 m tall and gives reference to the architecture of Alexandria.
''',
  constructionInfo2:
      '''The facade of the Treasury features a broken pediment with a central tholos (“dome”) inside, and two obelisks appear to form into the rock of Petra at the top. Near the bottom of the Treasury we see twin Greek Gods: Pollux, Castor, and Dioscuri, who protect travelers on their journeys. 
Near the top of the Treasury, two victories are seen standing on each side of a female figure on the tholos. This female figure is believed to be the Isis-Tyche, Isis being the Egyptian Goddess and Tyche being the Greek Goddess of good fortune.
''',
  locationInfo:
      '''Petra is located in southern Jordan. It is adjacent to the mountain of Jabal Al-Madbah, in a basin surrounded by mountains forming the eastern flank of the Arabah valley running from the Dead Sea to the Gulf of Aqaba.
The Nabataeans were nomadic Arabs who invested in Petra's proximity to the incense trade routes by establishing it as a major regional trading hub. Petra controlled the commercial caravan trade routes which passed through it to Gaza in the west, to Bosra and Damascus in the north, to Aqaba and Leuce Come on the Red Sea, and across the desert to the Persian Gulf.
''',
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
  events: const {
    -1200: 'First Edomites occupied the area and established a foothold.',
    -106: 'Became part of the Roman province Arabia',
    551: 'After being damaged by earthquakes, habitation of the city all but ceased.',
    1812: 'Rediscovered by the Swiss traveler Johann Ludwig Burckhardt.',
    1958:
        'Excavations led on the site by the British School of Archaeology and the American Center of Oriental Research.',
    1989: 'Appeared in the film Indiana Jones and The Last Crusade.',
  },
);
