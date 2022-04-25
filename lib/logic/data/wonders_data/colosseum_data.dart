import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/mock_data.dart';

final colosseumData = WonderData(
  type: WonderType.colosseum,
  title: 'Colosseum',
  subTitle: 'The icon of Rome',
  regionTitle: 'Rome, Italy',
  videoId: 'GXoEpNjgKzg',
  startYr: 70,
  endYr: 80,
  artifactStartYr: 1,
  artifactEndYr: 500,
  artifactCulture: 'Roman',
  artifactGeolocation: 'Roman Empire',
  lat: 41.890278,
  lng: 12.492222,
  imageIds: mockImageIds,
  unsplashCollectionId: 'VPdti8Kjq9o',
  quote1: 'The largest standing amphitheater',
  quote2: 'in the world today',
  quoteAuthor: '',
  historyInfo1:
      '''The Colosseum is an oval amphitheater in the center of the city of Rome, Italy. Unlike Roman theaters that were built into hillsides, the Colosseum is an entirely free-standing structure.
It was used for gladiatorial contests and public spectacles including animal hunts, executions, reenactments of famous battles, and dramas based on Roman mythology, and mock sea battles.
''',
  historyInfo2:
      '''The building ceased to be used for entertainment in the early medieval era. By the late 6th century a small chapel had been built into the structure of the amphitheater, and the arena was converted into a cemetery. The numerous vaulted spaces in the arcades under the seating were converted into housing and workshops, and are recorded as still being rented out as late as the 12th century.
''',
  constructionInfo1:
      '''Construction began under the emperor Vespasian (r. 69–79 AD) in 72 and was completed in 80 AD under his successor and heir, Titus (r. 79–81). Further modifications were made during the reign of Domitian (r. 81–96).
The Colosseum is built of travertine limestone, tuff (volcanic rock), and brick-faced concrete. The outer wall is estimated to have required over 3.5 million cubic feet of travertine stone which were set without mortar; they were held together by 300 tons of iron clamps.
''',
  constructionInfo2:
      '''It is the largest ancient amphitheater ever built, and is still the largest standing amphitheater in the world today, despite its age. It could hold an estimated 50,000 to 80,000 spectators at various points in its history, having an average audience of some 65,000.
''',
  locationInfo:
      '''Following the Great Fire of Rome in 64 AD, Emperor Nero seized much of the destroyed area to build his grandiose Domus Aurea ("Golden House"). A severe embarrassment to Nero's successors, parts of this extravagant palace and grounds, encompassing 1 sq mile, were filled with earth and built over.
On the site of the lake, in the middle of the palace grounds, Emperor Vespasian would build the Colosseum as part of a Roman resurgence. A public entertainment space replacing a symbol of imperial excess.
''',
  highlightArtifacts: const [
    '255960',
    '247993',
    '250464',
    '255960',
  ],
  hiddenArtifacts: const [
    '245376',
    '256570',
    '286136',
  ],
  events: const {
    70: 'Colosseum construction was started during the Vespasian reign overtop what used to be a private lake for the previous four emperors. This was done in an attempt to revitalize Rome from their tyrannical reign.',
    82: 'The uppermost floor was built, and the structure was officially completed by Domitian.',
    1140:
        'The arena was repurposed as a fortress for the Frangipane and Annibaldi families. It was also at one point used as a church.',
    1490:
        'Pope Alexander VI permitted the site to be used as a quarry, for both storing and salvaging building materials.',
    1829:
        'Preservation of the colosseum officially began, after more than a millennia of dilapidation and vandalism. Pope Pius VIII was notably devoted to this project.',
    1990:
        'A restoration project was undertaken to ensure the colosseum remained a major tourist attraction for Rome. It currently stands as one of the greatest sources of tourism revenue in Italy.',
  },
);
