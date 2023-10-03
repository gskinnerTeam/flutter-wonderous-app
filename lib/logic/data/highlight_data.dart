import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class HighlightData {
  HighlightData({
    required this.title,
    required this.culture,
    required this.artifactId,
    required this.wonder,
    required this.date,
  });

  static HighlightData? fromId(String? id) => id == null ? null : _highlights.firstWhereOrNull((o) => o.id == id);
  static List<HighlightData> forWonder(WonderType wonder) =>
      _highlights.where((o) => o.wonder == wonder).toList(growable: false);
  static List<HighlightData> get all => _highlights;

  final String title;
  final String culture;
  final String date;

  late final ImageProvider icon;

  final String artifactId;
  final WonderType wonder;

  String get id => artifactId;
  String get subtitle => wondersLogic.getData(wonder).artifactCulture;

  String get imageUrl => ArtifactData.getSelfHostedImageUrl(artifactId);
  String get imageUrlSmall => ArtifactData.getSelfHostedImageUrlSmall(artifactId);
}

// Note: look up a human readable page with:
// https://www.metmuseum.org/art/collection/search/503940
// where 503940 is the ID.
List<HighlightData> _highlights = [
  // chichenItza
  HighlightData(
    title: 'Double Whistle',
    wonder: WonderType.chichenItza,
    artifactId: '503940',
    culture: 'Mayan',
    date: '7th–9th century',
  ),
  HighlightData(
    title: 'Seated Female Figure',
    wonder: WonderType.chichenItza,
    artifactId: '312595',
    culture: 'Maya',
    date: '6th–9th century',
  ),
  HighlightData(
    title: 'Censer Support',
    wonder: WonderType.chichenItza,
    artifactId: '310551',
    culture: 'Maya',
    date: 'mid-7th–9th century',
  ),
  HighlightData(
    title: 'Tripod Plate',
    wonder: WonderType.chichenItza,
    artifactId: '316304',
    culture: 'Maya',
    date: '9th–10th century',
  ),
  HighlightData(
    title: 'Costumed Figure',
    wonder: WonderType.chichenItza,
    artifactId: '313151',
    culture: 'Maya',
    date: '7th–8th century',
  ),
  HighlightData(
    title: 'Head of a Rain God',
    wonder: WonderType.chichenItza,
    artifactId: '310480',
    culture: 'Maya',
    date: '10th–11th century',
  ),

// christRedeemer
  HighlightData(
    title: '[Studio Portrait: Male Street Vendor Holding Box of Flowers, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764815',
    culture: '',
    date: '1864–66',
  ),
  HighlightData(
    title: 'Rattle',
    wonder: WonderType.christRedeemer,
    artifactId: '502019',
    culture: 'Native American (Brazilian)',
    date: '19th century',
  ),
  HighlightData(
    title: '[Studio Portrait: Two Males Wearing Hats and Ponchos, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764814',
    culture: '',
    date: '1864–66',
  ),
  HighlightData(
    title: '[Studio Portrait: Female Street Vendor Seated Wearing Turban, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764816',
    culture: '',
    date: '1864–66',
  ),
  HighlightData(
    title: 'Pluriarc',
    wonder: WonderType.christRedeemer,
    artifactId: '501319',
    culture: 'African American (Brazil - Afro-Brazilian?)',
    date: 'late 19th century',
  ),

// colosseum
  HighlightData(
    title: 'Marble portrait of a young woman',
    wonder: WonderType.colosseum,
    artifactId: '251350',
    culture: 'Roman',
    date: 'A.D. 150–175',
  ),
  HighlightData(
    title: 'Silver mirror',
    wonder: WonderType.colosseum,
    artifactId: '255960',
    culture: 'Roman',
    date: '4th century A.D.',
  ),
  HighlightData(
    title: 'Marble portrait of the emperor Augustus',
    wonder: WonderType.colosseum,
    artifactId: '247993',
    culture: 'Roman',
    date: 'ca. A.D. 14–37',
  ),
  HighlightData(
    title: 'Terracotta medallion',
    wonder: WonderType.colosseum,
    artifactId: '250464',
    culture: 'Roman',
    date: 'late 2nd–early 3rd century A.D.',
  ),
  HighlightData(
    title: 'Marble head and torso of Athena',
    wonder: WonderType.colosseum,
    artifactId: '251476',
    culture: 'Roman',
    date: '1st–2nd century A.D.',
  ),
  HighlightData(
    title: 'Silver mirror',
    wonder: WonderType.colosseum,
    artifactId: '255960',
    culture: 'Roman',
    date: '4th century A.D.',
  ),

// greatWall
  HighlightData(
    title: 'Cape',
    wonder: WonderType.greatWall,
    artifactId: '79091',
    culture: 'French',
    date: 'second half 16th century',
  ),
  HighlightData(
    title: 'Censer in the form of a mythical beast',
    wonder: WonderType.greatWall,
    artifactId: '781812',
    culture: 'China',
    date: 'early 17th century',
  ),
  HighlightData(
    title: 'Dish with peafowls and peonies',
    wonder: WonderType.greatWall,
    artifactId: '40213',
    culture: 'China',
    date: 'early 15th century',
  ),
  HighlightData(
    title: 'Base for a mandala',
    wonder: WonderType.greatWall,
    artifactId: '40765',
    culture: 'China',
    date: '15th century',
  ),
  HighlightData(
    title: 'Bodhisattva Manjushri as Tikshna-Manjushri (Minjie Wenshu)',
    wonder: WonderType.greatWall,
    artifactId: '57612',
    culture: 'China',
    date: '',
  ),
  HighlightData(
    title: 'Tripod incense burner with lid',
    wonder: WonderType.greatWall,
    artifactId: '666573',
    culture: 'China',
    date: 'early 15th century',
  ),

// machuPicchu
  HighlightData(
    title: 'Face Beaker',
    wonder: WonderType.machuPicchu,
    artifactId: '313295',
    culture: 'Inca',
    date: '14th–early 16th century',
  ),
  HighlightData(
    title: 'Feathered Bag',
    wonder: WonderType.machuPicchu,
    artifactId: '316926',
    culture: 'Inca',
    date: '15th–early 16th century',
  ),
  HighlightData(
    title: 'Female Figurine',
    wonder: WonderType.machuPicchu,
    artifactId: '309944',
    culture: 'Inca',
    date: '1400–1533',
  ),
  HighlightData(
    title: 'Stirrup Spout Bottle with Felines',
    wonder: WonderType.machuPicchu,
    artifactId: '309436',
    culture: 'Moche',
    date: '4th–7th century',
  ),
  HighlightData(
    title: 'Camelid figurine',
    wonder: WonderType.machuPicchu,
    artifactId: '309960',
    culture: 'Inca',
    date: '1400–1533',
  ),
  HighlightData(
    title: 'Temple Model',
    wonder: WonderType.machuPicchu,
    artifactId: '316873',
    culture: 'Aztec',
    date: '1400–1521',
  ),

// petra
  HighlightData(
    title: 'Unguentarium',
    wonder: WonderType.petra,
    artifactId: '325900',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),
  HighlightData(
    title: 'Cooking pot',
    wonder: WonderType.petra,
    artifactId: '325902',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),
  HighlightData(
    title: 'Lamp',
    wonder: WonderType.petra,
    artifactId: '325919',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),
  HighlightData(
    title: 'Bowl',
    wonder: WonderType.petra,
    artifactId: '325884',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),
  HighlightData(
    title: 'Small lamp',
    wonder: WonderType.petra,
    artifactId: '325887',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),
  HighlightData(
    title: 'Male figurine',
    wonder: WonderType.petra,
    artifactId: '325891',
    culture: 'Nabataean',
    date: 'ca. 1st century A.D.',
  ),

// pyramidsGiza
  HighlightData(
    title: 'Guardian Figure',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543864',
    culture: '',
    date: 'ca. 1919–1885 B.C.',
  ),
  HighlightData(
    title: 'Relief fragment',
    wonder: WonderType.pyramidsGiza,
    artifactId: '546488',
    culture: '',
    date: 'ca. 1981–1640 B.C.',
  ),
  HighlightData(
    title: 'Ring with Uninscribed Scarab',
    wonder: WonderType.pyramidsGiza,
    artifactId: '557137',
    culture: '',
    date: 'ca. 1850–1640 B.C.',
  ),
  HighlightData(
    title: 'Nikare as a scribe',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543900',
    culture: '',
    date: 'ca. 2420–2389 B.C. or later',
  ),
  HighlightData(
    title: 'Seated Statue of King Menkaure',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543935',
    culture: '',
    date: 'ca. 2490–2472 B.C.',
  ),
  HighlightData(
    title: 'Floral collar from Tutankhamun\'s Embalming Cache',
    wonder: WonderType.pyramidsGiza,
    artifactId: '544782',
    culture: '',
    date: 'ca. 1336–1327 B.C.',
  ),

// tajMahal
  HighlightData(
    title: 'Mango-Shaped Flask',
    wonder: WonderType.tajMahal,
    artifactId: '453341',
    culture: '',
    date: 'mid-17th century',
  ),
  HighlightData(
    title: 'Base for a Water Pipe (Huqqa) with Irises',
    wonder: WonderType.tajMahal,
    artifactId: '453243',
    culture: '',
    date: 'late 17th century',
  ),
  HighlightData(
    title: 'Plate',
    wonder: WonderType.tajMahal,
    artifactId: '73309',
    culture: 'India (Gujarat)',
    date: 'mid-16th–17th century',
  ),
  HighlightData(
    title: 'Helmet',
    wonder: WonderType.tajMahal,
    artifactId: '24932',
    culture: 'Indian, Mughal',
    date: '18th century',
  ),
  HighlightData(
    title: 'Jewelled plate',
    wonder: WonderType.tajMahal,
    artifactId: '56230',
    culture: 'India',
    date: '18th–19th century',
  ),
  HighlightData(
    title: 'Shirt of Mail and Plate of Emperor Shah Jahan (reigned 1624–58)',
    wonder: WonderType.tajMahal,
    artifactId: '35633',
    culture: 'Indian',
    date: 'dated A.H. 1042/A.D. 1632–33',
  ),
];
