import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

part 'search/taj_mahal_search_data.dart';

final tajMahalData = WonderData(
  searchData: _searchData, // included as a part from ./search/
  searchSuggestions: _searchSuggestions, // included as a part from ./search/
  type: WonderType.tajMahal,
  title: 'Taj Mahal',
  subTitle: 'Heaven on Earth',
  regionTitle: 'Agra, India',
  videoId: 'EWkDzLrhpXI',
  startYr: 1632,
  endYr: 1653,
  artifactStartYr: 1300,
  artifactEndYr: 1800,
  artifactCulture: 'Mughal',
  artifactGeolocation: 'India',
  lat: 27.17405039840427,
  lng: 78.04211890065208,
  unsplashCollectionId: '684IRta86_c',
  pullQuote1Top: 'Not just a Monument,',
  pullQuote1Bottom: 'but a Symbol of Love.',
  pullQuote1Author: 'Suman Pokhrel',
  pullQuote2: 'The Taj Mahal rises above the banks of the river like a solitary tear suspended on the cheek of time.',
  pullQuote2Author: 'Rabindranath Tagore',
  callout1:
      'The Taj Mahal is distinguished as the finest example of Mughal architecture, a blend of Indian, Persian, and Islamic styles.',
  callout2:
      'It took the efforts of 22,000 laborers, painters, embroidery artists and stonecutters to shape the Taj Mahal.',
  videoCaption: '',
  mapCaption: '',
  historyInfo1:
      '''The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 CE by the Mughal emperor Shah Jahan (r. 1628-1658) to house the tomb of his favorite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.
''',
  historyInfo2:
      '''The Taj Mahal is distinguished as the finest example of Mughal architecture, a blend of Indian, Persian, and Islamic styles.
The tomb is the centerpiece of a 42-acre (17-hectare) complex, which include twin mosque buildings (placed symmetrically on either side of the mausoleum), a guest house, and is set in formal gardens bounded on three sides by walls.
''',
  constructionInfo1:
      '''The Taj Mahal was constructed using materials from all over India and Asia. It is believed over 1,000 elephants were used to transport building materials
The translucent white marble was brought from Rajasthan, the jasper from Punjab, jade and crystal from China. The turquoise was from Tibet and the lapis from Afghanistan, while the sapphire came from Sri Lanka. In all, twenty-eight types of precious and semi-precious stones were inlaid into the white marble.
''',
  constructionInfo2:
      '''It took the efforts of 22,000 laborers, painters, embroidery artists and stonecutters to shape the Taj Mahal. 
An area of roughly 3 acres was excavated, filled with dirt to reduce seepage, and leveled at 160 ft above riverbank. In the tomb area, wells were dug and filled with stone and rubble to form the footings of the tomb.
The plinth and tomb took roughly 12 years to complete. The remaining parts of the complex took an additional 10 years.
''',
  locationInfo:
      '''India's most famed building, it is situated in the eastern part of the city on the southern bank of the Yamuna River, nearly 1 mile east of the Agra Fort, also on the right bank of the Yamuna. The Taj Mahal is built on a parcel of land to the south of the walled city of Agra. Shah Jahan presented Maharaja Jai Singh with a large palace in the center of Agra in exchange for the land.
''',
  highlightArtifacts: const [
    '453341',
    '453243',
    '73309',
    '24932',
    '56230',
    '35633',
  ],
  hiddenArtifacts: const [
    '24907',
    '453183',
    '453983',
  ],
  events: const {
    1631: 'Built by Mughal Emperor Shah Jahān to immortalize his deceased wife.',
    1647: 'Construction completed. The project involved over 20,000 workers and spanned 42 acres.',
    1658:
        'There were plans for a second mausoleum for his own remains, but Shah Jahān was imprisoned by his son for the rest of his life in Agra Fort, and this never came to pass.',
    1901:
        'Lord Curzon and the British Viceroy of India carried out a major restoration to the monument after over 350 years of decay and corrosion due to factory pollution and exhaust. ',
    1984:
        'To protect the structure from Sikh militants and some Hindu nationalist groups, night viewing was banned to tourists. This ban would last 20 years.',
    1998: 'Restoration and research program put into action to help preserve the monument.',
  },
);
