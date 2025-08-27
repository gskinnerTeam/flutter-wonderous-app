// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Wonderous';

  @override
  String get localeSwapButton => '简体中文';

  @override
  String animatedArrowSemanticSwipe(Object title) {
    return 'Explore details about $title.';
  }

  @override
  String get appBarTitleFactsHistory => 'Facts and History';

  @override
  String get appBarTitleConstruction => 'Construction';

  @override
  String get appBarTitleLocation => 'Location Info';

  @override
  String get bottomScrubberSemanticScrubber => 'scrubber';

  @override
  String get bottomScrubberSemanticTimeline =>
      'Timeline Scrubber, drag horizontally to navigate the timeline.';

  @override
  String collectionLabelDiscovered(Object percentage) {
    return '$percentage% discovered';
  }

  @override
  String collectionLabelCount(Object count, Object total) {
    return '$count of $total';
  }

  @override
  String get collectionButtonReset => 'Reset Collection';

  @override
  String get eventsListButtonOpenGlobal => 'Open global timeline';

  @override
  String newlyDiscoveredSemanticNew(Object count, Object suffix) {
    return '$count new item$suffix to explore. Scroll to new item';
  }

  @override
  String newlyDiscoveredLabelNew(Object count, Object suffix) {
    return '$count new item$suffix to explore';
  }

  @override
  String get resultsPopupEnglishContent =>
      'This content is provided by the Metropolitan Museum of Art Collection API, and is only available in English.';

  @override
  String get resultsSemanticDismiss => 'dismiss message';

  @override
  String get scrollingContentSemanticYoutube => 'Youtube thumbnail';

  @override
  String get scrollingContentSemanticOpen => 'Open fullscreen maps view';

  @override
  String get searchInputTitleSuggestions => 'Suggestions';

  @override
  String get searchInputHintSearch => 'Search (ex. type or material)';

  @override
  String get searchInputSemanticClear => 'clear search';

  @override
  String timelineSemanticDate(Object fromDate, Object endDate) {
    return '$fromDate to $endDate';
  }

  @override
  String titleLabelDate(Object fromDate, Object endDate) {
    return '$fromDate to $endDate';
  }

  @override
  String get appModalsButtonOk => 'Ok';

  @override
  String get appModalsButtonCancel => 'Cancel';

  @override
  String get appPageDefaultTitlePage => 'page';

  @override
  String appPageSemanticSwipe(Object pageTitle, Object current, Object total) {
    return '$pageTitle $current of $total.';
  }

  @override
  String get artifactsTitleArtifacts => 'ARTIFACTS';

  @override
  String semanticsPrevious(Object title) {
    return 'Previous $title';
  }

  @override
  String semanticsNext(Object title) {
    return 'Next $title';
  }

  @override
  String get artifactsSemanticsPrevious => 'Previous artifact';

  @override
  String get artifactsSemanticsNext => 'Next artifact';

  @override
  String get artifactsSemanticArtifact => 'Artifact';

  @override
  String get artifactsButtonBrowse => 'Browse all artifacts';

  @override
  String get artifactDetailsLabelDate => 'Date';

  @override
  String get artifactDetailsLabelPeriod => 'Period';

  @override
  String get artifactDetailsLabelGeography => 'Geography';

  @override
  String get artifactDetailsLabelMedium => 'Medium';

  @override
  String get artifactDetailsLabelDimension => 'Dimension';

  @override
  String get artifactDetailsLabelClassification => 'Classification';

  @override
  String get artifactDetailsSemanticThumbnail => 'thumbnail image';

  @override
  String artifactDetailsErrorNotFound(Object artifactId) {
    return 'Unable to find info for artifact $artifactId ';
  }

  @override
  String get artifactsSearchTitleBrowse => 'Browse Artifacts';

  @override
  String get artifactsSearchLabelNotFound => 'No artifacts found';

  @override
  String get artifactsSearchButtonToggle => 'Toggle Timeframe';

  @override
  String get artifactsSearchSemanticTimeframe => 'timeframe';

  @override
  String artifactsSearchLabelFound(Object numFound, Object numResults) {
    return '$numFound artifacts found, $numResults in ';
  }

  @override
  String get artifactsSearchLabelAdjust => 'Adjust your';

  @override
  String get artifactsSearchLabelSearch => 'search terms';

  @override
  String get artifactsSearchLabelTimeframe => 'timeframe';

  @override
  String get circleButtonsSemanticClose => 'close';

  @override
  String get circleButtonsSemanticBack => 'back';

  @override
  String get collectibleFoundTitleArtifactDiscovered => 'Artifact Discovered';

  @override
  String get collectibleFoundButtonViewCollection => 'view in my collection';

  @override
  String get collectibleItemSemanticCollectible => 'collectible item';

  @override
  String get collectionTitleCollection => 'Collection';

  @override
  String get collectionPopupResetConfirm =>
      'Are you sure you want to reset your collection?';

  @override
  String get eightWaySemanticSwipeDetector => 'eight-way swipe detector';

  @override
  String get expandingTimeSelectorSemanticSelector => 'time range selector';

  @override
  String get fullscreenImageViewerSemanticFull =>
      'full screen image, no description available';

  @override
  String get homeMenuButtonExplore => 'Explore the timeline';

  @override
  String get homeMenuButtonView => 'View your collection';

  @override
  String get homeMenuButtonAbout => 'About this app';

  @override
  String get homeMenuAboutWonderous =>
      'Wonderous is a visual showcase of eight wonders of the world. ';

  @override
  String homeMenuAboutBuilt(Object flutterUrl, Object gskinnerUrl) {
    return 'Built with $flutterUrl by the team at $gskinnerUrl.';
  }

  @override
  String homeMenuAboutLearn(Object wonderousUrl) {
    return 'Learn more at $wonderousUrl.';
  }

  @override
  String homeMenuAboutSource(Object githubUrl) {
    return 'To see the source code for this app, please visit the $githubUrl.';
  }

  @override
  String get homeMenuAboutRepo => 'Wonderous github repo';

  @override
  String get homeMenuAboutFlutter => 'Flutter';

  @override
  String get homeMenuAboutGskinner => 'gskinner';

  @override
  String get homeMenuAboutApp => 'wonderous.app';

  @override
  String homeMenuAboutPublic(Object metUrl) {
    return 'Public-domain artworks from $metUrl.';
  }

  @override
  String get homeMenuAboutMet => 'The Metropolitan Museum of Art, New York';

  @override
  String homeMenuAboutPhotography(Object unsplashUrl) {
    return 'Photography from $unsplashUrl.';
  }

  @override
  String get homeMenuAboutUnsplash => 'Unsplash';

  @override
  String get introTitleJourney => 'Journey to the past';

  @override
  String get introDescriptionNavigate =>
      'Navigate the intersection of time, art, and culture.';

  @override
  String get introTitleExplore => 'Explore places';

  @override
  String get introDescriptionUncover =>
      'Uncover remarkable human-made structures from around the world.';

  @override
  String get introTitleDiscover => 'Discover artifacts';

  @override
  String get introDescriptionLearn =>
      'Learn about cultures throughout time by examining things they left behind.';

  @override
  String get introSemanticNavigate => 'Navigate';

  @override
  String get introSemanticSwipeLeft => 'Swipe left to continue';

  @override
  String get introSemanticEnterApp => 'Enter the app';

  @override
  String get introSemanticWonderous => 'Wonderous';

  @override
  String get labelledToggleSemanticToggle => 'toggle';

  @override
  String get photoGallerySemanticCollectible => 'collectible!';

  @override
  String photoGallerySemanticFocus(Object photoIndex, Object photoTotal) {
    return 'Photo $photoIndex of $photoTotal. Tap to focus.';
  }

  @override
  String photoGallerySemanticFullscreen(Object photoIndex, Object photoTotal) {
    return 'Photo $photoIndex of $photoTotal. Tap to open fullscreen view.';
  }

  @override
  String get eraPrehistory => 'Prehistory';

  @override
  String get eraClassical => 'Classical Era';

  @override
  String get eraEarlyModern => 'Early Modern Era';

  @override
  String get eraModern => 'Modern Era';

  @override
  String get yearBCE => 'BCE';

  @override
  String get yearCE => 'CE';

  @override
  String yearFormat(Object date, Object era) {
    return '$date $era';
  }

  @override
  String get year => 'Year';

  @override
  String timelineLabelConstruction(Object title) {
    return 'Construction of $title begins.';
  }

  @override
  String get timelineTitleGlobalTimeline => 'Global Timeline';

  @override
  String get wallpaperModalSave => 'Save this poster to your photo gallery?';

  @override
  String get wallpaperModalSaving => 'Saving Image. Please wait...';

  @override
  String get wallpaperModalSaveComplete => 'Save complete!';

  @override
  String get wallpaperSemanticSharePhoto => 'share photo';

  @override
  String get wallpaperSemanticTakePhoto => 'take photo';

  @override
  String get wallpaperCheckboxShowTitle => 'Show Title';

  @override
  String get wonderDetailsTabLabelInformation => 'information and history';

  @override
  String get wonderDetailsTabLabelImages => 'photo gallery';

  @override
  String get wonderDetailsTabLabelArtifacts => 'artifacts';

  @override
  String get wonderDetailsTabLabelEvents => 'events';

  @override
  String get wonderDetailsTabSemanticBack => 'back to wonder selection';

  @override
  String get homeSemanticOpenMain => 'Open main menu';

  @override
  String get homeSemanticWonder => 'wonder';

  @override
  String get chichenItzaTitle => 'Chichen Itza';

  @override
  String get chichenItzaSubTitle => 'The Great Mayan City';

  @override
  String get chichenItzaRegionTitle => 'Yucatan, Mexico';

  @override
  String get chichenItzaArtifactCulture => 'Maya';

  @override
  String get chichenItzaArtifactGeolocation => 'North and Central America';

  @override
  String get chichenItzaPullQuote1Top => 'The Beauty Between';

  @override
  String get chichenItzaPullQuote1Bottom => 'the Heavens and the Underworld';

  @override
  String get chichenItzaPullQuote2 =>
      'The Maya and Toltec vision of the world and the universe is revealed in their stone monuments and artistic works.';

  @override
  String get chichenItzaPullQuote2Author => 'UNESCO';

  @override
  String get chichenItzaCallout1 =>
      'The site exhibits a multitude of architectural styles, reminiscent of styles seen in central Mexico and of the Puuc and Chenes styles of the Northern Maya lowlands.';

  @override
  String get chichenItzaCallout2 =>
      'The city comprised an area of at least 1.9 sq miles (5 sq km) of densely clustered architecture.';

  @override
  String get chichenItzaVideoCaption =>
      '“Ancient Maya 101 | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get chichenItzaMapCaption =>
      'Map showing location of Chichen Itza in Yucatán State, Mexico.';

  @override
  String get chichenItzaHistoryInfo1 =>
      'Chichen Itza was a powerful regional capital controlling north and central Yucatán. The earliest hieroglyphic date discovered at Chichen Itza is equivalent to 832 CE, while the last known date was recorded in the Osario temple in 998 CE.\nDominating the North Platform of Chichen Itza is the famous Temple of Kukulcán. The temple was identified by the first Spaniards to see it, as El Castillo (\"the castle\"), and it regularly is referred to as such.';

  @override
  String get chichenItzaHistoryInfo2 =>
      'The city was thought to have the most diverse population in the Maya world, a factor that could have contributed to this architectural variety.';

  @override
  String get chichenItzaConstructionInfo1 =>
      'The structures of Chichen Itza were built from precisely chiseled limestone blocks that fit together perfectly without the mortar. Many of these stone buildings were originally painted in red, green, blue and purple colors depending on the availability of the pigments.\nThe stepped pyramid El Castillo stands about 98 feet (30 m) high and consists of a series of nine square terraces, each approximately 8.4 feet (2.57 m) high, with a 20 foot (6 m) high temple upon the summit.';

  @override
  String get chichenItzaConstructionInfo2 =>
      'It was built upon broken terrain, which was artificially leveled to support structures such as the Castillo pyramid. Important buildings within the center were connected by a dense network of paved roads called sacbeob.';

  @override
  String get chichenItzaLocationInfo1 =>
      'Chichen Itza is located in the eastern portion of Yucatán state in Mexico. Nearby, four large sinkholes, called cenotes, could have provided plentiful water year round at Chichen, making it attractive for settlement.';

  @override
  String get chichenItzaLocationInfo2 =>
      'Of these cenotes, the \"Cenote Sagrado\" or Sacred Cenote, was used for the sacrifice of precious objects and human beings as a form of worship to the Maya rain god Chaac.';

  @override
  String get chichenItza600ce =>
      'Chichen Itza rises to regional prominence toward the end of the Early Classic period';

  @override
  String get chichenItza832ce =>
      'The earliest hieroglyphic date discovered at Chichen Itza';

  @override
  String get chichenItza998ce =>
      'Last known date recorded in the Osario temple';

  @override
  String get chichenItza1100ce => 'Chichen Itza declines as a regional center';

  @override
  String get chichenItza1527ce =>
      'Invaded by Spanish Conquistador Francisco de Montejo';

  @override
  String get chichenItza1535ce =>
      'All Spanish are driven from the Yucatán Peninsula';

  @override
  String get chichenItzaCollectible1Title => 'Pendant';

  @override
  String get chichenItzaCollectible1Icon => 'jewelry';

  @override
  String get chichenItzaCollectible2Title => 'Bird Ornament';

  @override
  String get chichenItzaCollectible2Icon => 'jewelry';

  @override
  String get chichenItzaCollectible3Title => 'La Prison, à Chichen-Itza';

  @override
  String get chichenItzaCollectible3Icon => 'picture';

  @override
  String get christRedeemerTitle => 'Christ the Redeemer';

  @override
  String get christRedeemerSubTitle => 'A symbol of peace';

  @override
  String get christRedeemerRegionTitle => 'Rio de Janeiro, Brazil';

  @override
  String get christRedeemerArtifactGeolocation => 'Brazil';

  @override
  String get christRedeemerPullQuote1Top => 'A Perfect Union Between';

  @override
  String get christRedeemerPullQuote1Bottom => 'Nature and Architecture';

  @override
  String get christRedeemerPullQuote2 =>
      'The statue looms large on the landscape, but it hides as much as it reveals about the diverse religious life of Brazilians.';

  @override
  String get christRedeemerPullQuote2Author => 'Thomas Tweed';

  @override
  String get christRedeemerCallout1 =>
      'The statue of Christ the Redeemer with open arms, a symbol of peace, was chosen.';

  @override
  String get christRedeemerCallout2 =>
      'Construction took nine years, from 1922 to 1931, and cost the equivalent of US\$250,000 (equivalent to \$3,600,000 in 2020) and the monument opened on October 12, 1931.';

  @override
  String get christRedeemerVideoCaption =>
      '“The Majestic Statue of Christ the Redeemer - Seven Wonders of the Modern World - See U in History.” Youtube, uploaded by See U in History / Mythology.';

  @override
  String get christRedeemerMapCaption =>
      'Map showing location of Christ the Redeemer in Rio de Janeiro, Brazil.';

  @override
  String get christRedeemerHistoryInfo1 =>
      'The placement of a Christian monument on Mount Corcovado was first suggested in the mid-1850s to honor Princess Isabel, regent of Brazil and the daughter of Emperor Pedro II, but the project was not approved.\nIn 1889 the country became a republic, and owing to the separation of church and state the proposed statue was dismissed.';

  @override
  String get christRedeemerHistoryInfo2 =>
      'The Catholic Circle of Rio made a second proposal for a landmark statue on the mountain in 1920. The group organized an event called Semana do Monumento (\"Monument Week\") to attract donations and collect signatures to support the building of the statue. The organization was motivated by what they perceived as \"Godlessness\" in the society.\nThe designs considered for the \"Statue of the Christ\" included a representation of the Christian cross, a statue of Jesus with a globe in his hands, and a pedestal symbolizing the world.';

  @override
  String get christRedeemerConstructionInfo1 =>
      'Artist Carlos Oswald and local engineer Heitor da Silva Costa designed the statue. French sculptor Paul Landowski created the work. In 1922, Landowski commissioned fellow Parisian Romanian sculptor Gheorghe Leonida, who studied sculpture at the Fine Arts Conservatory in Bucharest and in Italy.';

  @override
  String get christRedeemerConstructionInfo2 =>
      'A group of engineers and technicians studied Landowski\'s submissions and felt building the structure of reinforced concrete instead of steel was more suitable for the cross-shaped statue. The concrete making up the base was supplied from Limhamn, Sweden. The outer layers are soapstone, chosen for its enduring qualities and ease of use.';

  @override
  String get christRedeemerLocationInfo1 =>
      'Corcovado, which means \"hunchback\" in Portuguese, is a mountain in central Rio de Janeiro, Brazil. It is a 2,329 foot (710 m) granite peak located in the Tijuca Forest, a national park.';

  @override
  String get christRedeemerLocationInfo2 =>
      'Corcovado hill lies just west of the city center but is wholly within the city limits and visible from great distances.';

  @override
  String get christRedeemer1850ce =>
      'Plans for the statue were first proposed by Pedro Maria Boss upon Mount Corcovado. This was never approved, however.';

  @override
  String get christRedeemer1921ce =>
      'A new plan was proposed by the Roman Catholic archdiocese, and after the citizens of Rio de Janeiro petitioned the president, it was finally approved.';

  @override
  String get christRedeemer1922ce =>
      'The foundation of the statue was ceremoniously laid out to commemorate Brazil’s independence from Portugal.';

  @override
  String get christRedeemer1926ce =>
      'Construction officially began after the initial design was chosen via a competition and amended by Brazilian artists and engineers.';

  @override
  String get christRedeemer1931ce =>
      'Construction of the statue was completed, standing 98’ tall with a 92’ wide arm span.';

  @override
  String get christRedeemer2006ce =>
      'A chapel was consecrated at the statue’s base to Our Lady of Aparecida to mark the statue’s 75th anniversary.';

  @override
  String get christRedeemerCollectible1Title => 'Engraved Horn';

  @override
  String get christRedeemerCollectible1Icon => 'statue';

  @override
  String get christRedeemerCollectible2Title => 'Fixed fan';

  @override
  String get christRedeemerCollectible2Icon => 'jewelry';

  @override
  String get christRedeemerCollectible3Title => 'Handkerchiefs (one of two)';

  @override
  String get christRedeemerCollectible3Icon => 'textile';

  @override
  String get colosseumTitle => 'Colosseum';

  @override
  String get colosseumSubTitle => 'The icon of Rome';

  @override
  String get colosseumRegionTitle => 'Rome, Italy';

  @override
  String get colosseumArtifactCulture => 'Roman';

  @override
  String get colosseumArtifactGeolocation => 'Roman Empire';

  @override
  String get colosseumPullQuote1Top => 'Still the Largest Standing';

  @override
  String get colosseumPullQuote1Bottom => 'Amphitheater in the World Today';

  @override
  String get colosseumPullQuote2 =>
      'When falls the Coliseum, Rome shall fall; And when Rome falls - the World.';

  @override
  String get colosseumPullQuote2Author => 'Lord Byron';

  @override
  String get colosseumCallout1 =>
      'It was used for gladiatorial contests and public spectacles including animal hunts, executions, reenactments of famous battles, and dramas based on Roman mythology, and mock sea battles.';

  @override
  String get colosseumCallout2 =>
      'It is the largest ancient amphitheater ever built, and is still the largest standing amphitheater in the world today, despite its age.';

  @override
  String get colosseumVideoCaption =>
      '“Ancient Rome 101 | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get colosseumMapCaption =>
      'Map showing location of Colosseum in Rome, Italy,';

  @override
  String get colosseumHistoryInfo1 =>
      'The Colosseum is an oval amphitheater in the center of the city of Rome, Italy. Unlike Roman theaters that were built into hillsides, the Colosseum is an entirely free-standing structure.';

  @override
  String get colosseumHistoryInfo2 =>
      'The building ceased to be used for entertainment in the early medieval era. By the late 6th century a small chapel had been built into the structure of the amphitheater, and the arena was converted into a cemetery. \nThe numerous vaulted spaces in the arcades under the seating were converted into housing and workshops, and are recorded as still being rented out as late as the 12th century.';

  @override
  String get colosseumConstructionInfo1 =>
      'Construction began under the emperor Vespasian (r. 69-79 CE) in 72 and was completed in 80 CE under his successor and heir, Titus (r. 79-81). Further modifications were made during the reign of Domitian (r. 81-96).\nThe Colosseum is built of travertine limestone, tuff (volcanic rock), and brick-faced concrete. The outer wall is estimated to have required over 3.5 million cubic feet of travertine stone which were set without mortar; they were held together by 300 tons of iron clamps.';

  @override
  String get colosseumConstructionInfo2 =>
      'It could hold an estimated 50,000 to 80,000 spectators at various points in its history, having an average audience of some 65,000.';

  @override
  String get colosseumLocationInfo1 =>
      'Following the Great Fire of Rome in 64 CE, Emperor Nero seized much of the destroyed area to build his grandiose Domus Aurea (\"Golden House\"). A severe embarrassment to Nero\'s successors, parts of this extravagant palace and grounds, encompassing 1 sq mile, were filled with earth and built over.';

  @override
  String get colosseumLocationInfo2 =>
      'On the site of the lake, in the middle of the palace grounds, Emperor Vespasian would build the Colosseum as part of a Roman resurgence.';

  @override
  String get colosseum70ce =>
      'Colosseum construction was started during the Vespasian reign overtop what used to be a private lake for the previous four emperors. This was done in an attempt to revitalize Rome from their tyrannical reign.';

  @override
  String get colosseum82ce =>
      'The uppermost floor was built, and the structure was officially completed by Domitian.';

  @override
  String get colosseum1140ce =>
      'The arena was repurposed as a fortress for the Frangipane and Annibaldi families. It was also at one point used as a church.';

  @override
  String get colosseum1490ce =>
      'Pope Alexander VI permitted the site to be used as a quarry, for both storing and salvaging building materials.';

  @override
  String get colosseum1829ce =>
      'Preservation of the colosseum officially began, after more than a millennia of dilapidation and vandalism. Pope Pius VIII was notably devoted to this project.';

  @override
  String get colosseum1990ce =>
      'A restoration project was undertaken to ensure the colosseum remained a major tourist attraction for Rome. It currently stands as one of the greatest sources of tourism revenue in Italy.';

  @override
  String get colosseumCollectible1Title => 'Glass hexagonal amphoriskos';

  @override
  String get colosseumCollectible1Icon => 'vase';

  @override
  String get colosseumCollectible2Title =>
      'Bronze plaque of Mithras slaying the bull';

  @override
  String get colosseumCollectible2Icon => 'statue';

  @override
  String get colosseumCollectible3Title => 'Interno del Colosseo';

  @override
  String get colosseumCollectible3Icon => 'picture';

  @override
  String get greatWallTitle => 'The Great Wall';

  @override
  String get greatWallSubTitle => 'Longest structure on Earth';

  @override
  String get greatWallRegionTitle => 'China';

  @override
  String get greatWallArtifactCulture => 'Chinese';

  @override
  String get greatWallArtifactGeolocation => 'China';

  @override
  String get greatWallPullQuote1Top => 'The Longest Man-Made';

  @override
  String get greatWallPullQuote1Bottom => 'Structure in the World';

  @override
  String get greatWallPullQuote2 =>
      'Its historic and strategic importance is matched only by its architectural significance.';

  @override
  String get greatWallPullQuote2Author => 'UNESCO';

  @override
  String get greatWallCallout1 =>
      'The best-known sections of the wall were built by the Ming dynasty (1368-1644).';

  @override
  String get greatWallCallout2 =>
      'During the Ming dynasty, however, bricks were heavily used in many areas of the wall, as were materials such as tiles, lime, and stone.';

  @override
  String get greatWallVideoCaption =>
      '“See China’s Iconic Great Wall From Above | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get greatWallMapCaption =>
      'Map showing location of Great Wall of China in northern China.';

  @override
  String get greatWallHistoryInfo1 =>
      'The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. The total length of all sections ever built is over 13,000 miles.';

  @override
  String get greatWallHistoryInfo2 =>
      'Several walls were built from as early as the 7th century BCE, with selective stretches later joined together by Qin Shi Huang (220-206  BCE), the first emperor of China. Little of the Qin wall remains. \nLater on, many successive dynasties built and maintained multiple stretches of border walls.';

  @override
  String get greatWallConstructionInfo1 =>
      'Transporting the large quantity of materials required for construction was difficult, so builders always tried to use local resources. Stones from the mountains were used over mountain ranges, while rammed earth was used for construction in the plains. Most of the ancient walls have eroded away over the centuries.';

  @override
  String get greatWallConstructionInfo2 =>
      'Stones cut into rectangular shapes were used for the foundation, inner and outer brims, and gateways of the wall. \nUnder the rule of the Qing dynasty, China\'s borders extended beyond the walls and Mongolia was annexed into the empire, so construction was discontinued.';

  @override
  String get greatWallLocationInfo1 =>
      'The frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino-Russian border in the north to Tao River in the south; along an arc that roughly delineates the edge of the Mongolian steppe.';

  @override
  String get greatWallLocationInfo2 =>
      'Apart from defense, other purposes of the Great Wall have included border controls, allowing the imposition of duties on goods transported along the Silk Road, regulation or encouragement of trade and the control of immigration and emigration.';

  @override
  String get greatWall700bce =>
      'First landmark of the Great Wall began originally as a square wall surrounding the state of Chu. Over the years, additional walls would be built and added to it to expand and connect territory.';

  @override
  String get greatWall214bce =>
      'The first Qin Emperor unifies China and links the wall of the surrounding states of Qin, Yan, and Zhao into the Great Wall of China, taking 10 years to build with hundreds of thousands of laborers.';

  @override
  String get greatWall121bce =>
      'A 20-year construction project was started by the Han emperor to build east and west sections of the wall, including beacons, towers, and castles. Not just for defense, but also to control trade routes like the Silk Road.';

  @override
  String get greatWall556ce =>
      'The Bei Qi kingdom also launched several construction projects, utilizing over 1.8 million workers to repair and extend sections of the wall, adding to its length and even building a second inner wall around Shanxi.';

  @override
  String get greatWall618ce =>
      'The Great Wall was repaired during the Sui Dynasty and used to defend against Tujue attacks. Before and after the Sui Dynasty, the wall saw very little use and fell into disrepair.';

  @override
  String get greatWall1487ce =>
      'Hongzhi Emperor split the walls into north and south lines, eventually shaping it into how it is today. Since then, it has gradually fallen into disrepair and remains mostly unused.';

  @override
  String get greatWallCollectible1Title =>
      'Biographies of Lian Po and Lin Xiangru';

  @override
  String get greatWallCollectible1Icon => 'scroll';

  @override
  String get greatWallCollectible2Title => 'Jar with Dragon';

  @override
  String get greatWallCollectible2Icon => 'vase';

  @override
  String get greatWallCollectible3Title => 'Panel with Peonies and Butterfly';

  @override
  String get greatWallCollectible3Icon => 'textile';

  @override
  String get machuPicchuTitle => 'Machu Picchu';

  @override
  String get machuPicchuSubTitle => 'Citadel of the Inca';

  @override
  String get machuPicchuRegionTitle => 'Cusco Region, Peru';

  @override
  String get machuPicchuArtifactCulture => 'Inca';

  @override
  String get machuPicchuArtifactGeolocation => 'South America';

  @override
  String get machuPicchuPullQuote1Top => 'Few Romances Can Ever Surpass';

  @override
  String get machuPicchuPullQuote1Bottom => 'That of the Granite Citadel';

  @override
  String get machuPicchuPullQuote1Author => 'Hiram Bingham';

  @override
  String get machuPicchuPullQuote2 =>
      'In the variety of its charms and the power of its spell, I know of no other place in the world which can compare with it.';

  @override
  String get machuPicchuPullQuote2Author => 'Hiram Bingham';

  @override
  String get machuPicchuCallout1 =>
      'During its use as a royal estate, it is estimated that about 750 people lived there, with most serving as support staff who lived there permanently.';

  @override
  String get machuPicchuCallout2 =>
      'The Incas were masters of this technique, called ashlar, in which blocks of stone are cut to fit together tightly without mortar.';

  @override
  String get machuPicchuVideoCaption =>
      '“Machu Picchu 101 | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get machuPicchuMapCaption =>
      'Map showing location of Machu Picchu in the Eastern Cordillera of southern Peru.';

  @override
  String get machuPicchuHistoryInfo1 =>
      'Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru on a 2,430-meter (7,970 ft) mountain ridge. Construction appears to date from two great Inca rulers, Pachacutec Inca Yupanqui (1438–1471 CE) and Túpac Inca Yupanqui (1472–1493 CE).';

  @override
  String get machuPicchuHistoryInfo2 =>
      'There is a consensus among archeologists that Pachacutec ordered the construction of the royal estate for his use as a retreat, most likely after a successful military campaign.\nRather it was used for 80 years before being abandoned, seemingly because of the Spanish conquests in other parts of the Inca Empire.';

  @override
  String get machuPicchuConstructionInfo1 =>
      'The central buildings use the classical Inca architectural style of polished dry-stone walls of regular shape. \nInca walls have many stabilizing features: doors and windows are trapezoidal, narrowing from bottom to top; corners usually are rounded; inside corners often incline slightly into the rooms, and outside corners were often tied together by \"L\"-shaped blocks.';

  @override
  String get machuPicchuConstructionInfo2 =>
      'This precision construction method made the structures at Machu Picchu resistant to seismic activity.\nThe site itself may have been intentionally built on fault lines to afford better drainage and a ready supply of fractured stone.';

  @override
  String get machuPicchuLocationInfo1 =>
      'Machu Picchu is situated above a bow of the Urubamba River, which surrounds the site on three sides, where cliffs drop vertically for 1,480 feet (450 m) to the river at their base. The location of the city was a military secret, and its deep precipices and steep mountains provided natural defenses.';

  @override
  String get machuPicchuLocationInfo2 =>
      'The Inca Bridge, an Inca grass rope bridge, across the Urubamba River in the Pongo de Mainique, provided a secret entrance for the Inca army. Another Inca bridge was built to the west of Machu Picchu, the tree-trunk bridge, at a location where a gap occurs in the cliff that measures 20 feet (6 m).';

  @override
  String get machuPicchu1438ce =>
      'Speculated to be built and occupied by Inca ruler Pachacuti Inca Yupanqui.';

  @override
  String get machuPicchu1572ce =>
      'The last Inca rulers used the site as a bastion to rebel against Spanish rule until they were ultimately wiped out.';

  @override
  String get machuPicchu1867ce =>
      'Speculated to have been originally discovered by German explorer Augusto Berns, but his findings were never effectively publicized.';

  @override
  String get machuPicchu1911ce =>
      'Introduced to the world by Hiram Bingham of Yale University, who was led there by locals after disclosing he was searching for Vilcabamba, the ’lost city of the Incas’.';

  @override
  String get machuPicchu1964ce =>
      'Surrounding sites were excavated thoroughly by Gene Savoy, who found a much more suitable candidate for Vilcabamba in the ruin known as Espíritu Pampa.';

  @override
  String get machuPicchu1997ce =>
      'Since its rediscovery, growing numbers of tourists have visited the Machu Picchu each year, with numbers exceeding 1.4 million in 2017.';

  @override
  String get machuPicchuCollectible1Title => 'Eight-Pointed Star Tunic';

  @override
  String get machuPicchuCollectible1Icon => 'textile';

  @override
  String get machuPicchuCollectible2Title => 'Camelid figurine';

  @override
  String get machuPicchuCollectible2Icon => 'statue';

  @override
  String get machuPicchuCollectible3Title => 'Double Bowl';

  @override
  String get machuPicchuCollectible3Icon => 'vase';

  @override
  String get petraTitle => 'Petra';

  @override
  String get petraSubTitle => 'The Lost City';

  @override
  String get petraRegionTitle => 'Ma’an, Jordan';

  @override
  String get petraArtifactCulture => 'Nabataean';

  @override
  String get petraArtifactGeolocation => 'Levant';

  @override
  String get petraPullQuote1Top => 'A Rose-Red City';

  @override
  String get petraPullQuote1Bottom => 'Half as Old as Time';

  @override
  String get petraPullQuote1Author => 'John William Burgon';

  @override
  String get petraPullQuote2 =>
      'Petra is a brilliant display of man’s artistry in turning barren rock into a majestic wonder.';

  @override
  String get petraPullQuote2Author => 'Edward Dawson';

  @override
  String get petraCallout1 =>
      'They were particularly skillful in harvesting rainwater, agriculture and stone carving.';

  @override
  String get petraCallout2 =>
      'Perhaps a more prominent resemblance to Hellenistic style in Petra comes with its Treasury.';

  @override
  String get petraVideoCaption =>
      '“Stunning Stone Monuments of Petra | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get petraMapCaption =>
      'Map showing location of Petra in Ma’an Governorate, Jordan.';

  @override
  String get petraHistoryInfo1 =>
      'The area around Petra has been inhabited from as early as 7000  BCE, and the Nabataeans might have settled in what would become the capital city of their kingdom as early as the 4th century BCE.\nThe trading business gained the Nabataeans considerable revenue and Petra became the focus of their wealth. The Nabataeans were accustomed to living in the barren deserts, unlike their enemies, and were able to repel attacks by taking advantage of the area\'s mountainous terrain.';

  @override
  String get petraHistoryInfo2 =>
      'Petra flourished in the 1st century CE, when its famous Al-Khazneh structure - believed to be the mausoleum of Nabataean king Aretas IV - was constructed, and its population peaked at an estimated 20,000 inhabitants.\nAccess to the city is through a 3/4 mile-long (1.2 km) gorge called the Siq, which leads directly to the Khazneh.';

  @override
  String get petraConstructionInfo1 =>
      'Famous for its rock-cut architecture and water conduit system, Petra is also called the \"Red Rose City\" because of the color of the stone from which it is carved.\nAnother thing Petra is known for is its Hellenistic (“Greek”) architecture. These influences can be seen in many of the facades at Petra and are a reflection of the cultures that the Nabataens traded with.';

  @override
  String get petraConstructionInfo2 =>
      'The facade of the Treasury features a broken pediment with a central tholos (“dome”) inside, and two obelisks appear to form into the rock of Petra at the top. Near the bottom of the Treasury we see twin Greek Gods: Pollux, Castor, and Dioscuri, who protect travelers on their journeys. \nNear the top of the Treasury, two victories are seen standing on each side of a female figure on the tholos. This female figure is believed to be the Isis-Tyche, Isis being the Egyptian Goddess and Tyche being the Greek Goddess of good fortune.';

  @override
  String get petraLocationInfo1 =>
      'Petra is located in southern Jordan. It is adjacent to the mountain of Jabal Al-Madbah, in a basin surrounded by mountains forming the eastern flank of the Arabah valley running from the Dead Sea to the Gulf of Aqaba.';

  @override
  String get petraLocationInfo2 =>
      'The area around Petra has been inhabited from as early as 7000 BC, and the Nabataeans might have settled in what would become the capital city of their kingdom as early as the 4th century BC.\nArchaeological work has only discovered evidence of Nabataean presence dating back to the second century BC, by which time Petra had become their capital. The Nabataeans were nomadic Arabs who invested in Petra\'s proximity to the incense trade routes by establishing it as a major regional trading hub.';

  @override
  String get petra1200bce =>
      'First Edomites occupied the area and established a foothold.';

  @override
  String get petra106bce => 'Became part of the Roman province Arabia';

  @override
  String get petra551ce =>
      'After being damaged by earthquakes, habitation of the city all but ceased.';

  @override
  String get petra1812ce =>
      'Rediscovered by the Swiss traveler Johann Ludwig Burckhardt.';

  @override
  String get petra1958ce =>
      'Excavations led on the site by the British School of Archaeology and the American Center of Oriental Research.';

  @override
  String get petra1989ce =>
      'Appeared in the film Indiana Jones and The Last Crusade.';

  @override
  String get petraCollectible1Title => 'Camel and riders';

  @override
  String get petraCollectible1Icon => 'statue';

  @override
  String get petraCollectible2Title => 'Vessel';

  @override
  String get petraCollectible2Icon => 'vase';

  @override
  String get petraCollectible3Title => 'Open bowl';

  @override
  String get petraCollectible3Icon => 'vase';

  @override
  String get pyramidsGizaTitle => 'Pyramids of Giza';

  @override
  String get pyramidsGizaSubTitle => 'The ancient wonder';

  @override
  String get pyramidsGizaRegionTitle => 'Cairo, Egypt';

  @override
  String get pyramidsGizaArtifactCulture => 'Egyptian';

  @override
  String get pyramidsGizaArtifactGeolocation => 'Egypt';

  @override
  String get pyramidsGizaPullQuote1Top => 'The Tallest Structures on Earth';

  @override
  String get pyramidsGizaPullQuote1Bottom =>
      'Until the Advent of Modern Skyscrapers';

  @override
  String get pyramidsGizaPullQuote2 =>
      'From the heights of these pyramids, forty centuries look down on us.';

  @override
  String get pyramidsGizaPullQuote2Author => 'Napoleon Bonaparte';

  @override
  String get pyramidsGizaCallout1 =>
      'It is theorized the pyramid not only served as a tomb for the pharaoh, but also as a storage pit for various items he would need in the afterlife.';

  @override
  String get pyramidsGizaCallout2 =>
      'The Great Pyramid consists of an estimated 2.3 million blocks. Approximately 5.5 million tonnes of limestone, 8,000 tonnes of granite, and 500,000 tonnes of mortar were used in the construction.';

  @override
  String get pyramidsGizaVideoCaption =>
      '“The Great Pyramids of Giza | Egypt’s Ancient Mysteries | National Geographic UK.” Youtube, uploaded by National Geographic UK.';

  @override
  String get pyramidsGizaMapCaption =>
      'Map showing location of Giza Pyramids in Greater Cairo, Egypt.';

  @override
  String get pyramidsGizaHistoryInfo1 =>
      'The Giza pyramid complex, also called the Giza necropolis, is the site on the Giza Plateau in Greater Cairo, Egypt that includes the Great Pyramid of Giza, the Pyramid of Khafre, and the Pyramid of Menkaure, along with their associated pyramid complexes and the Great Sphinx of Giza. All were built during the Fourth Dynasty of the Old Kingdom of Ancient Egypt, between 2600 and 2500 BCE.';

  @override
  String get pyramidsGizaHistoryInfo2 =>
      'The pyramids of Giza and others are thought to have been constructed to house the remains of the deceased pharaohs who ruled over Ancient Egypt. A portion of the pharaoh\'s spirit called his ka was believed to remain with his corpse. Proper care of the remains was necessary in order for the former Pharaoh to perform his new duties as king of the dead.';

  @override
  String get pyramidsGizaConstructionInfo1 =>
      'Most construction theories are based on the idea that the pyramids were built by moving huge stones from a quarry and dragging and lifting them into place. In building the pyramids, the architects might have developed their techniques over time.\nThey would select a site on a relatively flat area of bedrock — not sand — which provided a stable foundation. After carefully surveying the site and laying down the first level of stones, they constructed the pyramids in horizontal levels, one on top of the other.';

  @override
  String get pyramidsGizaConstructionInfo2 =>
      'For the Great Pyramid, most of the stone for the interior seems to have been quarried immediately to the south of the construction site. The smooth exterior of the pyramid was made of a fine grade of white limestone that was quarried across the Nile.\nTo ensure that the pyramid remained symmetrical, the exterior casing stones all had to be equal in height and width. Workers might have marked all the blocks to indicate the angle of the pyramid wall and trimmed the surfaces carefully so that the blocks fit together. During construction, the outer surface of the stone was smooth limestone; excess stone has eroded as time has passed.';

  @override
  String get pyramidsGizaLocationInfo1 =>
      'The site is at the edges of the Western Desert, approximately 5.6 miles (9 km) west of the Nile River in the city of Giza, and about 8 miles (13 km) southwest of the city center of Cairo.';

  @override
  String get pyramidsGizaLocationInfo2 =>
      'Currently, the pyramids are located in the northwestern side of the Western Desert, and it is considered to be one of the best recognizable and the most visited tourist attractions of the planet.';

  @override
  String get pyramidsGiza2575bce =>
      'Construction of the 3 pyramids began for three kings of the 4th dynasty; Khufu, Khafre, and Menkaure.';

  @override
  String get pyramidsGiza2465bce =>
      'Construction began on the smaller surrounding structures called Mastabas for royalty of the 5th and 6th dynasties.';

  @override
  String get pyramidsGiza443bce =>
      'Greek Author Herodotus speculated that the pyramids were built in the span of 20 years with over 100,000 slave labourers. This assumption would last for over 1500 years';

  @override
  String get pyramidsGiza1925ce =>
      'Tomb of Queen Hetepheres was discovered, containing furniture and jewelry. One of the last remaining treasure-filled tombs after many years of looting and plundering.';

  @override
  String get pyramidsGiza1979ce =>
      'Designated a UNESCO World Heritage Site to prevent any more unauthorized plundering and vandalism.';

  @override
  String get pyramidsGiza1990ce =>
      'Discovery of labouror’s districts suggest that the workers building the pyramids were not slaves, and an ingenious building method proved a relatively small work-force was required to build such immense structures.';

  @override
  String get pyramidsGizaCollectible1Title => 'Two papyrus fragments';

  @override
  String get pyramidsGizaCollectible1Icon => 'scroll';

  @override
  String get pyramidsGizaCollectible2Title => 'Fragmentary Face of King Khafre';

  @override
  String get pyramidsGizaCollectible2Icon => 'statue';

  @override
  String get pyramidsGizaCollectible3Title => 'Jewelry Elements';

  @override
  String get pyramidsGizaCollectible3Icon => 'jewelry';

  @override
  String get tajMahalTitle => 'Taj Mahal';

  @override
  String get tajMahalSubTitle => 'Heaven on Earth';

  @override
  String get tajMahalRegionTitle => 'Agra, India';

  @override
  String get tajMahalArtifactCulture => 'Mughal';

  @override
  String get tajMahalArtifactGeolocation => 'India';

  @override
  String get tajMahalPullQuote1Top => 'Not just a Monument,';

  @override
  String get tajMahalPullQuote1Bottom => 'but a Symbol of Love.';

  @override
  String get tajMahalPullQuote1Author => 'Suman Pokhrel';

  @override
  String get tajMahalPullQuote2 =>
      'The Taj Mahal rises above the banks of the river like a solitary tear suspended on the cheek of time.';

  @override
  String get tajMahalPullQuote2Author => 'Rabindranath Tagore';

  @override
  String get tajMahalCallout1 =>
      'The Taj Mahal is distinguished as the finest example of Mughal architecture, a blend of Indian, Persian, and Islamic styles.';

  @override
  String get tajMahalCallout2 =>
      'It took the efforts of 22,000 laborers, painters, embroidery artists and stonecutters to shape the Taj Mahal.';

  @override
  String get tajMahalVideoCaption =>
      '“India’s Taj Mahal Is an Enduring Monument to Love | National Geographic.” Youtube, uploaded by National Geographic.';

  @override
  String get tajMahalMapCaption =>
      'Map showing location of Taj Mahal in Uttar Pradesh, India.';

  @override
  String get tajMahalHistoryInfo1 =>
      'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 CE by the Mughal emperor Shah Jahan (r. 1628-1658) to house the tomb of his favorite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.';

  @override
  String get tajMahalHistoryInfo2 =>
      'The tomb is the centerpiece of a 42-acre (17-hectare) complex, which include twin mosque buildings (placed symmetrically on either side of the mausoleum), a guest house, and is set in formal gardens bounded on three sides by walls.';

  @override
  String get tajMahalConstructionInfo1 =>
      'The Taj Mahal was constructed using materials from all over India and Asia. It is believed over 1,000 elephants were used to transport building materials.\nThe translucent white marble was brought from Rajasthan, the jasper from Punjab, jade and crystal from China. The turquoise was from Tibet and the lapis from Afghanistan, while the sapphire came from Sri Lanka. In all, twenty-eight types of precious and semi-precious stones were inlaid into the white marble.';

  @override
  String get tajMahalConstructionInfo2 =>
      'An area of roughly 3 acres was excavated, filled with dirt to reduce seepage, and leveled at 160 ft above riverbank. In the tomb area, wells were dug and filled with stone and rubble to form the footings of the tomb.\nThe plinth and tomb took roughly 12 years to complete. The remaining parts of the complex took an additional 10 years.';

  @override
  String get tajMahalLocationInfo1 =>
      'India\'s most famed building, it is situated in the eastern part of the city on the southern bank of the Yamuna River, nearly 1 mile east of the Agra Fort, also on the right bank of the Yamuna.';

  @override
  String get tajMahalLocationInfo2 =>
      'The Taj Mahal is built on a parcel of land to the south of the walled city of Agra. Shah Jahan presented Maharaja Jai Singh with a large palace in the center of Agra in exchange for the land.';

  @override
  String get tajMahal1631ce =>
      'Built by Mughal Emperor Shah Jahān to immortalize his deceased wife.';

  @override
  String get tajMahal1647ce =>
      'Construction completed. The project involved over 20,000 workers and spanned 42 acres.';

  @override
  String get tajMahal1658ce =>
      'There were plans for a second mausoleum for his own remains, but Shah Jahān was imprisoned by his son for the rest of his life in Agra Fort, and this never came to pass.';

  @override
  String get tajMahal1901ce =>
      'Lord Curzon and the British Viceroy of India carried out a major restoration to the monument after over 350 years of decay and corrosion due to factory pollution and exhaust.';

  @override
  String get tajMahal1984ce =>
      'To protect the structure from Sikh militants and some Hindu nationalist groups, night viewing was banned to tourists. This ban would last 20 years.';

  @override
  String get tajMahal1998ce =>
      'Restoration and research program put into action to help preserve the monument.';

  @override
  String get tajMahalCollectible1Title => 'Dagger with Scabbard';

  @override
  String get tajMahalCollectible1Icon => 'jewelry';

  @override
  String get tajMahalCollectible2Title => 'The House of Bijapur';

  @override
  String get tajMahalCollectible2Icon => 'picture';

  @override
  String get tajMahalCollectible3Title => 'Panel of Nasta\'liq Calligraphy';

  @override
  String get tajMahalCollectible3Icon => 'scroll';

  @override
  String get timelineEvent2900bce => 'First known use of papyrus by Egyptians';

  @override
  String get timelineEvent2700bce => 'The Old Kingdom begins in Egypt';

  @override
  String get timelineEvent2600bce =>
      'Emergence of Mayan culture in the Yucatán Peninsula';

  @override
  String get timelineEvent2560bce =>
      'King Khufu completes the Great Pyramid of Giza';

  @override
  String get timelineEvent2500bce => 'The mammoth goes extinct';

  @override
  String get timelineEvent2200bce => 'Completion of Stonehenge';

  @override
  String get timelineEvent2000bce => 'Domestication of the horse';

  @override
  String get timelineEvent1800bce => 'Alphabetic writing emerges';

  @override
  String get timelineEvent890bce => 'Homer writes the Iliad and the Odyssey';

  @override
  String get timelineEvent776bce => 'First recorded Ancient Olympic Games';

  @override
  String get timelineEvent753bce => 'Founding of Rome';

  @override
  String get timelineEvent447bce =>
      'Building of the Parthenon at Athens started';

  @override
  String get timelineEvent427bce => 'Birth of Greek Philosopher Plato';

  @override
  String get timelineEvent322bce =>
      'Death of Aristotle (61), the first genuine scientist';

  @override
  String get timelineEvent200bce => 'Paper is invented in the Han Dynasty';

  @override
  String get timelineEvent44bce =>
      'Death of Julius Caesar; beginning of the Roman Empire';

  @override
  String get timelineEvent4bce => 'Birth of Jesus Christ';

  @override
  String get timelineEvent43ce =>
      'The Roman Empire enters Great Britain for the first time';

  @override
  String get timelineEvent79ce =>
      'Destruction of Pompeii by the volcano Vesuvius';

  @override
  String get timelineEvent455ce => 'End of the Roman Empire';

  @override
  String get timelineEvent500ce => 'Tikal becomes the first great Maya city';

  @override
  String get timelineEvent632ce => 'Death of Muhammad (61), founder of Islam';

  @override
  String get timelineEvent793ce => 'The Vikings first invade Britain';

  @override
  String get timelineEvent800ce => 'Gunpowder is invented in China';

  @override
  String get timelineEvent1001ce =>
      'Leif Erikson settles during the winter in present-day eastern Canada';

  @override
  String get timelineEvent1077ce =>
      'The Construction of the Tower of London begins';

  @override
  String get timelineEvent1117ce => 'The University of Oxford is founded';

  @override
  String get timelineEvent1199ce => 'Europeans first use compasses';

  @override
  String get timelineEvent1227ce => 'Death of Genghis Khan (65)';

  @override
  String get timelineEvent1337ce =>
      'The Hundred Years\' War begins as England and France struggle for dominance.';

  @override
  String get timelineEvent1347ce =>
      'The first of many concurrences of the Black Death plague, believed to have wiped out as many as 50% of Europe\'s population by its end';

  @override
  String get timelineEvent1428ce => 'Birth of the Aztec Empire in Mexico';

  @override
  String get timelineEvent1439ce =>
      'Johannes Gutenberg invents the printing press';

  @override
  String get timelineEvent1492ce =>
      'Christopher Columbus reaches the New World';

  @override
  String get timelineEvent1760ce => 'The industrial revolution begins';

  @override
  String get timelineEvent1763ce => 'Development of the Watt steam engine';

  @override
  String get timelineEvent1783ce =>
      'End of the American War of Independence from the British Empire';

  @override
  String get timelineEvent1789ce => 'The French Revolution begins';

  @override
  String get timelineEvent1914ce => 'World War I';

  @override
  String get timelineEvent1929ce =>
      'Black Tuesday signals the beginning of the Great Depression';

  @override
  String get timelineEvent1939ce => 'World War II';

  @override
  String get timelineEvent1957ce => 'launch of Sputnik 1 by the Soviet Union';

  @override
  String get timelineEvent1969ce => 'Apollo 11 mission lands on the moon';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String privacyStatement(Object privacyUrl) {
    return 'As explained in our $privacyUrl we do not collect any personal information.';
  }

  @override
  String get pageNotFoundBackButton => 'Back to civilization';

  @override
  String get pageNotFoundMessage =>
      'The page you are looking for does not exist.';
}
