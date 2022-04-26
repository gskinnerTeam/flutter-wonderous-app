import 'package:wonders/common_libs.dart';

class HighlightsData {
  HighlightsData({
    required this.title,
    required this.imageUrl,
    required this.culture,
    required this.artifactId,
    required this.wonder,
  });

  static HighlightsData? fromId(String? id) => id == null ? null : _highlights.firstWhereOrNull((o) => o.id == id);
  static List<HighlightsData> get all => _highlights;

  final String title;
  final String imageUrl;
  final String culture;

  late final ImageProvider icon;

  final String artifactId;
  final WonderType wonder;

  String get id => artifactId;
  String get subtitle => wondersLogic.getData(wonder).artifactCulture;
}

// Note: look up a human readable page with:
// https://www.metmuseum.org/art/collection/search/503940
// where 503940 is the ID.
List<HighlightsData> _highlights = [
  // chichenItza
  HighlightsData(
    title: 'Feathered Bag',
    wonder: WonderType.chichenItza,
    artifactId: '316926',
    culture: 'Inca',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP158704.jpg',
  ),
  HighlightsData(
    title: 'Double Whistle',
    wonder: WonderType.chichenItza,
    artifactId: '503940',
    culture: 'Mayan',
    imageUrl: 'https://images.metmuseum.org/CRDImages/mi/web-large/DT4624a.jpg',
  ),
  HighlightsData(
    title: 'Censer Support',
    wonder: WonderType.chichenItza,
    artifactId: '310551',
    culture: 'Maya',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP102949.jpg',
  ),
  HighlightsData(
    title: 'Seated Female Figure',
    wonder: WonderType.chichenItza,
    artifactId: '312595',
    culture: 'Maya',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP-12659-001.jpg',
  ),
  HighlightsData(
    title: 'Tripod Plate',
    wonder: WonderType.chichenItza,
    artifactId: '316304',
    culture: 'Maya',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP219258.jpg',
  ),
  HighlightsData(
    title: 'Costumed Figure',
    wonder: WonderType.chichenItza,
    artifactId: '313151',
    culture: 'Maya',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/1979.206.953_a.JPG',
  ),

// christRedeemer
  HighlightsData(
    title: '[Studio Portrait: Male Street Vendor Holding Box of Flowers, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764815',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP-15801-131.jpg',
  ),
  HighlightsData(
    title: 'Mirror-Bearer',
    wonder: WonderType.christRedeemer,
    artifactId: '313256',
    culture: 'Maya',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DT1254.jpg',
  ),
  HighlightsData(
    title: 'Rattle',
    wonder: WonderType.christRedeemer,
    artifactId: '502019',
    culture: 'Native American (Brazilian)',
    imageUrl: 'https://images.metmuseum.org/CRDImages/mi/web-large/midp89.4.1453.jpg',
  ),
  HighlightsData(
    title: '[Studio Portrait: Two Males Wearing Hats and Ponchos, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764814',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP-15801-129.jpg',
  ),
  HighlightsData(
    title: '[Studio Portrait: Female Street Vendor Seated Wearing Turban, Brazil]',
    wonder: WonderType.christRedeemer,
    artifactId: '764816',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP-15801-133.jpg',
  ),

// colosseum
  HighlightsData(
    title: 'Pluriarc',
    wonder: WonderType.colosseum,
    artifactId: '501319',
    culture: 'African American (Brazil - Afro-Brazilian?)',
    imageUrl: 'https://images.metmuseum.org/CRDImages/mi/web-large/midp89.4.703.jpg',
  ),
  HighlightsData(
    title: 'Marble portrait of a young woman',
    wonder: WonderType.colosseum,
    artifactId: '251350',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP331280.jpg',
  ),
  HighlightsData(
    title: 'Silver mirror',
    wonder: WonderType.colosseum,
    artifactId: '255960',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP145605.jpg',
  ),
  HighlightsData(
    title: 'Marble portrait of the emperor Augustus',
    wonder: WonderType.colosseum,
    artifactId: '247993',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP337220.jpg',
  ),
  HighlightsData(
    title: 'Terracotta medallion',
    wonder: WonderType.colosseum,
    artifactId: '250464',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP105842.jpg',
  ),
  HighlightsData(
    title: 'Marble head and torso of Athena',
    wonder: WonderType.colosseum,
    artifactId: '251476',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP357289.jpg',
  ),

// greatWall
  HighlightsData(
    title: 'Silver mirror',
    wonder: WonderType.greatWall,
    artifactId: '255960',
    culture: 'Roman',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP145605.jpg',
  ),
  HighlightsData(
    title: 'Cape',
    wonder: WonderType.greatWall,
    artifactId: '79091',
    culture: 'French',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ci/web-large/DT2183.jpg',
  ),
  HighlightsData(
    title: 'Censer in the form of a mythical beast',
    wonder: WonderType.greatWall,
    artifactId: '781812',
    culture: 'China',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP-17100-001.jpg',
  ),
  HighlightsData(
    title: 'Dish with peafowls and peonies',
    wonder: WonderType.greatWall,
    artifactId: '40213',
    culture: 'China',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP704217.jpg',
  ),
  HighlightsData(
    title: 'Base for a mandala',
    wonder: WonderType.greatWall,
    artifactId: '40765',
    culture: 'China',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP229015.jpg',
  ),
  HighlightsData(
    title: 'Bodhisattva Manjushri as Tikshna-Manjushri (Minjie Wenshu)',
    wonder: WonderType.greatWall,
    artifactId: '57612',
    culture: 'China',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP164061.jpg',
  ),

// machuPicchu
  HighlightsData(
    title: 'Tripod incense burner with lid',
    wonder: WonderType.machuPicchu,
    artifactId: '666573',
    culture: 'China',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP356342.jpg',
  ),
  HighlightsData(
    title: 'Face Beaker',
    wonder: WonderType.machuPicchu,
    artifactId: '313295',
    culture: 'Inca',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DT9410.jpg',
  ),
  HighlightsData(
    title: 'Feathered Bag',
    wonder: WonderType.machuPicchu,
    artifactId: '316926',
    culture: 'Inca',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP158704.jpg',
  ),
  HighlightsData(
    title: 'Female Figurine',
    wonder: WonderType.machuPicchu,
    artifactId: '309944',
    culture: 'Inca',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP-13440-023.jpg',
  ),
  HighlightsData(
    title: 'Stirrup Spout Bottle with Felines',
    wonder: WonderType.machuPicchu,
    artifactId: '309436',
    culture: 'Moche',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/67.92.jpg',
  ),
  HighlightsData(
    title: 'Camelid figurine',
    wonder: WonderType.machuPicchu,
    artifactId: '309960',
    culture: 'Inca',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP-13440-031.jpg',
  ),

// petra
  HighlightsData(
    title: 'Temple Model',
    wonder: WonderType.petra,
    artifactId: '316873',
    culture: 'Aztec',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP341942.jpg',
  ),
  HighlightsData(
    title: 'Unguentarium',
    wonder: WonderType.petra,
    artifactId: '325900',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_19.jpg',
  ),
  HighlightsData(
    title: 'Cooking pot',
    wonder: WonderType.petra,
    artifactId: '325902',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_21.jpg',
  ),
  HighlightsData(
    title: 'Lamp',
    wonder: WonderType.petra,
    artifactId: '325919',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_38.jpg',
  ),
  HighlightsData(
    title: 'Bowl',
    wonder: WonderType.petra,
    artifactId: '325884',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_3.jpg',
  ),
  HighlightsData(
    title: 'Small lamp',
    wonder: WonderType.petra,
    artifactId: '325887',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_6.jpg',
  ),

// pyramidsGiza
  HighlightsData(
    title: 'Male figurine',
    wonder: WonderType.pyramidsGiza,
    artifactId: '325891',
    culture: 'Nabataean',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/ME67_246_10.jpg',
  ),
  HighlightsData(
    title: 'Relief fragment',
    wonder: WonderType.pyramidsGiza,
    artifactId: '546488',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/LC-34_1_183_EGDP033257.jpg',
  ),
  HighlightsData(
    title: 'Guardian Figure',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543864',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DP330260.jpg',
  ),
  HighlightsData(
    title: 'Ring with Uninscribed Scarab',
    wonder: WonderType.pyramidsGiza,
    artifactId: '557137',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/15.3.205_EGDP015425.jpg',
  ),
  HighlightsData(
    title: 'Seated Statue of King Menkaure',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543935',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DP109397.jpg',
  ),
  HighlightsData(
    title: 'Nikare as a scribe',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543900',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DP240451.jpg',
  ),

// tajMahal
  HighlightsData(
    title: 'Floral collar from Tutankhamun\'s Embalming Cache',
    wonder: WonderType.tajMahal,
    artifactId: '544782',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DP225343.jpg',
  ),
  HighlightsData(
    title: 'Mango-Shaped Flask',
    wonder: WonderType.tajMahal,
    artifactId: '453341',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/is/web-large/DP240307.jpg',
  ),
  HighlightsData(
    title: 'Base for a Water Pipe (Huqqa) with Irises',
    wonder: WonderType.tajMahal,
    artifactId: '453243',
    culture: '',
    imageUrl: 'https://images.metmuseum.org/CRDImages/is/web-large/DP214317.jpg',
  ),
  HighlightsData(
    title: 'Plate',
    wonder: WonderType.tajMahal,
    artifactId: '73309',
    culture: 'India (Gujarat)',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP138506.jpg',
  ),
  HighlightsData(
    title: 'Helmet',
    wonder: WonderType.tajMahal,
    artifactId: '24932',
    culture: 'Indian, Mughal',
    imageUrl: 'https://images.metmuseum.org/CRDImages/aa/web-large/1988.147_007mar2015.jpg',
  ),
  HighlightsData(
    title: 'Jewelled plate',
    wonder: WonderType.tajMahal,
    artifactId: '56230',
    culture: 'India',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP-14153-029.jpg',
  ),
];
