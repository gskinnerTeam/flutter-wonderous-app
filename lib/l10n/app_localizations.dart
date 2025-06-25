import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Wonderous'**
  String get appName;

  /// No description provided for @localeSwapButton.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get localeSwapButton;

  /// No description provided for @animatedArrowSemanticSwipe.
  ///
  /// In en, this message translates to:
  /// **'Explore details about {title}.'**
  String animatedArrowSemanticSwipe(Object title);

  /// No description provided for @appBarTitleFactsHistory.
  ///
  /// In en, this message translates to:
  /// **'Facts and History'**
  String get appBarTitleFactsHistory;

  /// No description provided for @appBarTitleConstruction.
  ///
  /// In en, this message translates to:
  /// **'Construction'**
  String get appBarTitleConstruction;

  /// No description provided for @appBarTitleLocation.
  ///
  /// In en, this message translates to:
  /// **'Location Info'**
  String get appBarTitleLocation;

  /// No description provided for @bottomScrubberSemanticScrubber.
  ///
  /// In en, this message translates to:
  /// **'scrubber'**
  String get bottomScrubberSemanticScrubber;

  /// No description provided for @bottomScrubberSemanticTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline Scrubber, drag horizontally to navigate the timeline.'**
  String get bottomScrubberSemanticTimeline;

  /// No description provided for @collectionLabelDiscovered.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% discovered'**
  String collectionLabelDiscovered(Object percentage);

  /// No description provided for @collectionLabelCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total}'**
  String collectionLabelCount(Object count, Object total);

  /// No description provided for @collectionButtonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset Collection'**
  String get collectionButtonReset;

  /// No description provided for @eventsListButtonOpenGlobal.
  ///
  /// In en, this message translates to:
  /// **'Open global timeline'**
  String get eventsListButtonOpenGlobal;

  /// No description provided for @newlyDiscoveredSemanticNew.
  ///
  /// In en, this message translates to:
  /// **'{count} new item{suffix} to explore. Scroll to new item'**
  String newlyDiscoveredSemanticNew(Object count, Object suffix);

  /// No description provided for @newlyDiscoveredLabelNew.
  ///
  /// In en, this message translates to:
  /// **'{count} new item{suffix} to explore'**
  String newlyDiscoveredLabelNew(Object count, Object suffix);

  /// No description provided for @resultsPopupEnglishContent.
  ///
  /// In en, this message translates to:
  /// **'This content is provided by the Metropolitan Museum of Art Collection API, and is only available in English.'**
  String get resultsPopupEnglishContent;

  /// No description provided for @resultsSemanticDismiss.
  ///
  /// In en, this message translates to:
  /// **'dismiss message'**
  String get resultsSemanticDismiss;

  /// No description provided for @scrollingContentSemanticYoutube.
  ///
  /// In en, this message translates to:
  /// **'Youtube thumbnail'**
  String get scrollingContentSemanticYoutube;

  /// No description provided for @scrollingContentSemanticOpen.
  ///
  /// In en, this message translates to:
  /// **'Open fullscreen maps view'**
  String get scrollingContentSemanticOpen;

  /// No description provided for @searchInputTitleSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get searchInputTitleSuggestions;

  /// No description provided for @searchInputHintSearch.
  ///
  /// In en, this message translates to:
  /// **'Search (ex. type or material)'**
  String get searchInputHintSearch;

  /// No description provided for @searchInputSemanticClear.
  ///
  /// In en, this message translates to:
  /// **'clear search'**
  String get searchInputSemanticClear;

  /// No description provided for @timelineSemanticDate.
  ///
  /// In en, this message translates to:
  /// **'{fromDate} to {endDate}'**
  String timelineSemanticDate(Object fromDate, Object endDate);

  /// No description provided for @titleLabelDate.
  ///
  /// In en, this message translates to:
  /// **'{fromDate} to {endDate}'**
  String titleLabelDate(Object fromDate, Object endDate);

  /// No description provided for @appModalsButtonOk.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get appModalsButtonOk;

  /// No description provided for @appModalsButtonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get appModalsButtonCancel;

  /// No description provided for @appPageDefaultTitlePage.
  ///
  /// In en, this message translates to:
  /// **'page'**
  String get appPageDefaultTitlePage;

  /// No description provided for @appPageSemanticSwipe.
  ///
  /// In en, this message translates to:
  /// **'{pageTitle} {current} of {total}.'**
  String appPageSemanticSwipe(Object pageTitle, Object current, Object total);

  /// No description provided for @artifactsTitleArtifacts.
  ///
  /// In en, this message translates to:
  /// **'ARTIFACTS'**
  String get artifactsTitleArtifacts;

  /// No description provided for @semanticsPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous {title}'**
  String semanticsPrevious(Object title);

  /// No description provided for @semanticsNext.
  ///
  /// In en, this message translates to:
  /// **'Next {title}'**
  String semanticsNext(Object title);

  /// No description provided for @artifactsSemanticsPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous artifact'**
  String get artifactsSemanticsPrevious;

  /// No description provided for @artifactsSemanticsNext.
  ///
  /// In en, this message translates to:
  /// **'Next artifact'**
  String get artifactsSemanticsNext;

  /// No description provided for @artifactsSemanticArtifact.
  ///
  /// In en, this message translates to:
  /// **'Artifact'**
  String get artifactsSemanticArtifact;

  /// No description provided for @artifactsButtonBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse all artifacts'**
  String get artifactsButtonBrowse;

  /// No description provided for @artifactDetailsLabelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get artifactDetailsLabelDate;

  /// No description provided for @artifactDetailsLabelPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get artifactDetailsLabelPeriod;

  /// No description provided for @artifactDetailsLabelGeography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get artifactDetailsLabelGeography;

  /// No description provided for @artifactDetailsLabelMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get artifactDetailsLabelMedium;

  /// No description provided for @artifactDetailsLabelDimension.
  ///
  /// In en, this message translates to:
  /// **'Dimension'**
  String get artifactDetailsLabelDimension;

  /// No description provided for @artifactDetailsLabelClassification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get artifactDetailsLabelClassification;

  /// No description provided for @artifactDetailsSemanticThumbnail.
  ///
  /// In en, this message translates to:
  /// **'thumbnail image'**
  String get artifactDetailsSemanticThumbnail;

  /// No description provided for @artifactDetailsErrorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Unable to find info for artifact {artifactId} '**
  String artifactDetailsErrorNotFound(Object artifactId);

  /// No description provided for @artifactsSearchTitleBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse Artifacts'**
  String get artifactsSearchTitleBrowse;

  /// No description provided for @artifactsSearchLabelNotFound.
  ///
  /// In en, this message translates to:
  /// **'No artifacts found'**
  String get artifactsSearchLabelNotFound;

  /// No description provided for @artifactsSearchButtonToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Timeframe'**
  String get artifactsSearchButtonToggle;

  /// No description provided for @artifactsSearchSemanticTimeframe.
  ///
  /// In en, this message translates to:
  /// **'timeframe'**
  String get artifactsSearchSemanticTimeframe;

  /// No description provided for @artifactsSearchLabelFound.
  ///
  /// In en, this message translates to:
  /// **'{numFound} artifacts found, {numResults} in '**
  String artifactsSearchLabelFound(Object numFound, Object numResults);

  /// No description provided for @artifactsSearchLabelAdjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust your'**
  String get artifactsSearchLabelAdjust;

  /// No description provided for @artifactsSearchLabelSearch.
  ///
  /// In en, this message translates to:
  /// **'search terms'**
  String get artifactsSearchLabelSearch;

  /// No description provided for @artifactsSearchLabelTimeframe.
  ///
  /// In en, this message translates to:
  /// **'timeframe'**
  String get artifactsSearchLabelTimeframe;

  /// No description provided for @circleButtonsSemanticClose.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get circleButtonsSemanticClose;

  /// No description provided for @circleButtonsSemanticBack.
  ///
  /// In en, this message translates to:
  /// **'back'**
  String get circleButtonsSemanticBack;

  /// No description provided for @collectibleFoundTitleArtifactDiscovered.
  ///
  /// In en, this message translates to:
  /// **'Artifact Discovered'**
  String get collectibleFoundTitleArtifactDiscovered;

  /// No description provided for @collectibleFoundButtonViewCollection.
  ///
  /// In en, this message translates to:
  /// **'view in my collection'**
  String get collectibleFoundButtonViewCollection;

  /// No description provided for @collectibleItemSemanticCollectible.
  ///
  /// In en, this message translates to:
  /// **'collectible item'**
  String get collectibleItemSemanticCollectible;

  /// No description provided for @collectionTitleCollection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collectionTitleCollection;

  /// No description provided for @collectionPopupResetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset your collection?'**
  String get collectionPopupResetConfirm;

  /// No description provided for @eightWaySemanticSwipeDetector.
  ///
  /// In en, this message translates to:
  /// **'eight-way swipe detector'**
  String get eightWaySemanticSwipeDetector;

  /// No description provided for @expandingTimeSelectorSemanticSelector.
  ///
  /// In en, this message translates to:
  /// **'time range selector'**
  String get expandingTimeSelectorSemanticSelector;

  /// No description provided for @fullscreenImageViewerSemanticFull.
  ///
  /// In en, this message translates to:
  /// **'full screen image, no description available'**
  String get fullscreenImageViewerSemanticFull;

  /// No description provided for @homeMenuButtonExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore the timeline'**
  String get homeMenuButtonExplore;

  /// No description provided for @homeMenuButtonView.
  ///
  /// In en, this message translates to:
  /// **'View your collection'**
  String get homeMenuButtonView;

  /// No description provided for @homeMenuButtonAbout.
  ///
  /// In en, this message translates to:
  /// **'About this app'**
  String get homeMenuButtonAbout;

  /// No description provided for @homeMenuAboutWonderous.
  ///
  /// In en, this message translates to:
  /// **'Wonderous is a visual showcase of eight wonders of the world. '**
  String get homeMenuAboutWonderous;

  /// No description provided for @homeMenuAboutBuilt.
  ///
  /// In en, this message translates to:
  /// **'Built with {flutterUrl} by the team at {gskinnerUrl}.'**
  String homeMenuAboutBuilt(Object flutterUrl, Object gskinnerUrl);

  /// No description provided for @homeMenuAboutLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn more at {wonderousUrl}.'**
  String homeMenuAboutLearn(Object wonderousUrl);

  /// No description provided for @homeMenuAboutSource.
  ///
  /// In en, this message translates to:
  /// **'To see the source code for this app, please visit the {githubUrl}.'**
  String homeMenuAboutSource(Object githubUrl);

  /// No description provided for @homeMenuAboutRepo.
  ///
  /// In en, this message translates to:
  /// **'Wonderous github repo'**
  String get homeMenuAboutRepo;

  /// No description provided for @homeMenuAboutFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get homeMenuAboutFlutter;

  /// No description provided for @homeMenuAboutGskinner.
  ///
  /// In en, this message translates to:
  /// **'gskinner'**
  String get homeMenuAboutGskinner;

  /// No description provided for @homeMenuAboutApp.
  ///
  /// In en, this message translates to:
  /// **'wonderous.app'**
  String get homeMenuAboutApp;

  /// No description provided for @homeMenuAboutPublic.
  ///
  /// In en, this message translates to:
  /// **'Public-domain artworks from {metUrl}.'**
  String homeMenuAboutPublic(Object metUrl);

  /// No description provided for @homeMenuAboutMet.
  ///
  /// In en, this message translates to:
  /// **'The Metropolitan Museum of Art, New York'**
  String get homeMenuAboutMet;

  /// No description provided for @homeMenuAboutPhotography.
  ///
  /// In en, this message translates to:
  /// **'Photography from {unsplashUrl}.'**
  String homeMenuAboutPhotography(Object unsplashUrl);

  /// No description provided for @homeMenuAboutUnsplash.
  ///
  /// In en, this message translates to:
  /// **'Unsplash'**
  String get homeMenuAboutUnsplash;

  /// No description provided for @introTitleJourney.
  ///
  /// In en, this message translates to:
  /// **'Journey to the past'**
  String get introTitleJourney;

  /// No description provided for @introDescriptionNavigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate the intersection of time, art, and culture.'**
  String get introDescriptionNavigate;

  /// No description provided for @introTitleExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore places'**
  String get introTitleExplore;

  /// No description provided for @introDescriptionUncover.
  ///
  /// In en, this message translates to:
  /// **'Uncover remarkable human-made structures from around the world.'**
  String get introDescriptionUncover;

  /// No description provided for @introTitleDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover artifacts'**
  String get introTitleDiscover;

  /// No description provided for @introDescriptionLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn about cultures throughout time by examining things they left behind.'**
  String get introDescriptionLearn;

  /// No description provided for @introSemanticNavigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get introSemanticNavigate;

  /// No description provided for @introSemanticSwipeLeft.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to continue'**
  String get introSemanticSwipeLeft;

  /// No description provided for @introSemanticEnterApp.
  ///
  /// In en, this message translates to:
  /// **'Enter the app'**
  String get introSemanticEnterApp;

  /// No description provided for @introSemanticWonderous.
  ///
  /// In en, this message translates to:
  /// **'Wonderous'**
  String get introSemanticWonderous;

  /// No description provided for @labelledToggleSemanticToggle.
  ///
  /// In en, this message translates to:
  /// **'toggle'**
  String get labelledToggleSemanticToggle;

  /// No description provided for @photoGallerySemanticCollectible.
  ///
  /// In en, this message translates to:
  /// **'collectible!'**
  String get photoGallerySemanticCollectible;

  /// No description provided for @photoGallerySemanticFocus.
  ///
  /// In en, this message translates to:
  /// **'Photo {photoIndex} of {photoTotal}. Tap to focus.'**
  String photoGallerySemanticFocus(Object photoIndex, Object photoTotal);

  /// No description provided for @photoGallerySemanticFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Photo {photoIndex} of {photoTotal}. Tap to open fullscreen view.'**
  String photoGallerySemanticFullscreen(Object photoIndex, Object photoTotal);

  /// No description provided for @eraPrehistory.
  ///
  /// In en, this message translates to:
  /// **'Prehistory'**
  String get eraPrehistory;

  /// No description provided for @eraClassical.
  ///
  /// In en, this message translates to:
  /// **'Classical Era'**
  String get eraClassical;

  /// No description provided for @eraEarlyModern.
  ///
  /// In en, this message translates to:
  /// **'Early Modern Era'**
  String get eraEarlyModern;

  /// No description provided for @eraModern.
  ///
  /// In en, this message translates to:
  /// **'Modern Era'**
  String get eraModern;

  /// No description provided for @yearBCE.
  ///
  /// In en, this message translates to:
  /// **'BCE'**
  String get yearBCE;

  /// No description provided for @yearCE.
  ///
  /// In en, this message translates to:
  /// **'CE'**
  String get yearCE;

  /// No description provided for @yearFormat.
  ///
  /// In en, this message translates to:
  /// **'{date} {era}'**
  String yearFormat(Object date, Object era);

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @timelineLabelConstruction.
  ///
  /// In en, this message translates to:
  /// **'Construction of {title} begins.'**
  String timelineLabelConstruction(Object title);

  /// No description provided for @timelineTitleGlobalTimeline.
  ///
  /// In en, this message translates to:
  /// **'Global Timeline'**
  String get timelineTitleGlobalTimeline;

  /// No description provided for @wallpaperModalSave.
  ///
  /// In en, this message translates to:
  /// **'Save this poster to your photo gallery?'**
  String get wallpaperModalSave;

  /// No description provided for @wallpaperModalSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving Image. Please wait...'**
  String get wallpaperModalSaving;

  /// No description provided for @wallpaperModalSaveComplete.
  ///
  /// In en, this message translates to:
  /// **'Save complete!'**
  String get wallpaperModalSaveComplete;

  /// No description provided for @wallpaperSemanticSharePhoto.
  ///
  /// In en, this message translates to:
  /// **'share photo'**
  String get wallpaperSemanticSharePhoto;

  /// No description provided for @wallpaperSemanticTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'take photo'**
  String get wallpaperSemanticTakePhoto;

  /// No description provided for @wallpaperCheckboxShowTitle.
  ///
  /// In en, this message translates to:
  /// **'Show Title'**
  String get wallpaperCheckboxShowTitle;

  /// No description provided for @wonderDetailsTabLabelInformation.
  ///
  /// In en, this message translates to:
  /// **'information and history'**
  String get wonderDetailsTabLabelInformation;

  /// No description provided for @wonderDetailsTabLabelImages.
  ///
  /// In en, this message translates to:
  /// **'photo gallery'**
  String get wonderDetailsTabLabelImages;

  /// No description provided for @wonderDetailsTabLabelArtifacts.
  ///
  /// In en, this message translates to:
  /// **'artifacts'**
  String get wonderDetailsTabLabelArtifacts;

  /// No description provided for @wonderDetailsTabLabelEvents.
  ///
  /// In en, this message translates to:
  /// **'events'**
  String get wonderDetailsTabLabelEvents;

  /// No description provided for @wonderDetailsTabSemanticBack.
  ///
  /// In en, this message translates to:
  /// **'back to wonder selection'**
  String get wonderDetailsTabSemanticBack;

  /// No description provided for @homeSemanticOpenMain.
  ///
  /// In en, this message translates to:
  /// **'Open main menu'**
  String get homeSemanticOpenMain;

  /// No description provided for @homeSemanticWonder.
  ///
  /// In en, this message translates to:
  /// **'wonder'**
  String get homeSemanticWonder;

  /// No description provided for @chichenItzaTitle.
  ///
  /// In en, this message translates to:
  /// **'Chichen Itza'**
  String get chichenItzaTitle;

  /// No description provided for @chichenItzaSubTitle.
  ///
  /// In en, this message translates to:
  /// **'The Great Mayan City'**
  String get chichenItzaSubTitle;

  /// No description provided for @chichenItzaRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Yucatan, Mexico'**
  String get chichenItzaRegionTitle;

  /// No description provided for @chichenItzaArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Maya'**
  String get chichenItzaArtifactCulture;

  /// No description provided for @chichenItzaArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'North and Central America'**
  String get chichenItzaArtifactGeolocation;

  /// No description provided for @chichenItzaPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'The Beauty Between'**
  String get chichenItzaPullQuote1Top;

  /// No description provided for @chichenItzaPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'the Heavens and the Underworld'**
  String get chichenItzaPullQuote1Bottom;

  /// No description provided for @chichenItzaPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'The Maya and Toltec vision of the world and the universe is revealed in their stone monuments and artistic works.'**
  String get chichenItzaPullQuote2;

  /// No description provided for @chichenItzaPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'UNESCO'**
  String get chichenItzaPullQuote2Author;

  /// No description provided for @chichenItzaCallout1.
  ///
  /// In en, this message translates to:
  /// **'The site exhibits a multitude of architectural styles, reminiscent of styles seen in central Mexico and of the Puuc and Chenes styles of the Northern Maya lowlands.'**
  String get chichenItzaCallout1;

  /// No description provided for @chichenItzaCallout2.
  ///
  /// In en, this message translates to:
  /// **'The city comprised an area of at least 1.9 sq miles (5 sq km) of densely clustered architecture.'**
  String get chichenItzaCallout2;

  /// No description provided for @chichenItzaVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“Ancient Maya 101 | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get chichenItzaVideoCaption;

  /// No description provided for @chichenItzaMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Chichen Itza in Yucatán State, Mexico.'**
  String get chichenItzaMapCaption;

  /// No description provided for @chichenItzaHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'Chichen Itza was a powerful regional capital controlling north and central Yucatán. The earliest hieroglyphic date discovered at Chichen Itza is equivalent to 832 CE, while the last known date was recorded in the Osario temple in 998 CE.\nDominating the North Platform of Chichen Itza is the famous Temple of Kukulcán. The temple was identified by the first Spaniards to see it, as El Castillo (\"the castle\"), and it regularly is referred to as such.'**
  String get chichenItzaHistoryInfo1;

  /// No description provided for @chichenItzaHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'The city was thought to have the most diverse population in the Maya world, a factor that could have contributed to this architectural variety.'**
  String get chichenItzaHistoryInfo2;

  /// No description provided for @chichenItzaConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'The structures of Chichen Itza were built from precisely chiseled limestone blocks that fit together perfectly without the mortar. Many of these stone buildings were originally painted in red, green, blue and purple colors depending on the availability of the pigments.\nThe stepped pyramid El Castillo stands about 98 feet (30 m) high and consists of a series of nine square terraces, each approximately 8.4 feet (2.57 m) high, with a 20 foot (6 m) high temple upon the summit.'**
  String get chichenItzaConstructionInfo1;

  /// No description provided for @chichenItzaConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'It was built upon broken terrain, which was artificially leveled to support structures such as the Castillo pyramid. Important buildings within the center were connected by a dense network of paved roads called sacbeob.'**
  String get chichenItzaConstructionInfo2;

  /// No description provided for @chichenItzaLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'Chichen Itza is located in the eastern portion of Yucatán state in Mexico. Nearby, four large sinkholes, called cenotes, could have provided plentiful water year round at Chichen, making it attractive for settlement.'**
  String get chichenItzaLocationInfo1;

  /// No description provided for @chichenItzaLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'Of these cenotes, the \"Cenote Sagrado\" or Sacred Cenote, was used for the sacrifice of precious objects and human beings as a form of worship to the Maya rain god Chaac.'**
  String get chichenItzaLocationInfo2;

  /// No description provided for @chichenItza600ce.
  ///
  /// In en, this message translates to:
  /// **'Chichen Itza rises to regional prominence toward the end of the Early Classic period'**
  String get chichenItza600ce;

  /// No description provided for @chichenItza832ce.
  ///
  /// In en, this message translates to:
  /// **'The earliest hieroglyphic date discovered at Chichen Itza'**
  String get chichenItza832ce;

  /// No description provided for @chichenItza998ce.
  ///
  /// In en, this message translates to:
  /// **'Last known date recorded in the Osario temple'**
  String get chichenItza998ce;

  /// No description provided for @chichenItza1100ce.
  ///
  /// In en, this message translates to:
  /// **'Chichen Itza declines as a regional center'**
  String get chichenItza1100ce;

  /// No description provided for @chichenItza1527ce.
  ///
  /// In en, this message translates to:
  /// **'Invaded by Spanish Conquistador Francisco de Montejo'**
  String get chichenItza1527ce;

  /// No description provided for @chichenItza1535ce.
  ///
  /// In en, this message translates to:
  /// **'All Spanish are driven from the Yucatán Peninsula'**
  String get chichenItza1535ce;

  /// No description provided for @chichenItzaCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Pendant'**
  String get chichenItzaCollectible1Title;

  /// No description provided for @chichenItzaCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'jewelry'**
  String get chichenItzaCollectible1Icon;

  /// No description provided for @chichenItzaCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Bird Ornament'**
  String get chichenItzaCollectible2Title;

  /// No description provided for @chichenItzaCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'jewelry'**
  String get chichenItzaCollectible2Icon;

  /// No description provided for @chichenItzaCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'La Prison, à Chichen-Itza'**
  String get chichenItzaCollectible3Title;

  /// No description provided for @chichenItzaCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'picture'**
  String get chichenItzaCollectible3Icon;

  /// No description provided for @christRedeemerTitle.
  ///
  /// In en, this message translates to:
  /// **'Christ the Redeemer'**
  String get christRedeemerTitle;

  /// No description provided for @christRedeemerSubTitle.
  ///
  /// In en, this message translates to:
  /// **'A symbol of peace'**
  String get christRedeemerSubTitle;

  /// No description provided for @christRedeemerRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Rio de Janeiro, Brazil'**
  String get christRedeemerRegionTitle;

  /// No description provided for @christRedeemerArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get christRedeemerArtifactGeolocation;

  /// No description provided for @christRedeemerPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'A Perfect Union Between'**
  String get christRedeemerPullQuote1Top;

  /// No description provided for @christRedeemerPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'Nature and Architecture'**
  String get christRedeemerPullQuote1Bottom;

  /// No description provided for @christRedeemerPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'The statue looms large on the landscape, but it hides as much as it reveals about the diverse religious life of Brazilians.'**
  String get christRedeemerPullQuote2;

  /// No description provided for @christRedeemerPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Thomas Tweed'**
  String get christRedeemerPullQuote2Author;

  /// No description provided for @christRedeemerCallout1.
  ///
  /// In en, this message translates to:
  /// **'The statue of Christ the Redeemer with open arms, a symbol of peace, was chosen.'**
  String get christRedeemerCallout1;

  /// No description provided for @christRedeemerCallout2.
  ///
  /// In en, this message translates to:
  /// **'Construction took nine years, from 1922 to 1931, and cost the equivalent of US\$250,000 (equivalent to \$3,600,000 in 2020) and the monument opened on October 12, 1931.'**
  String get christRedeemerCallout2;

  /// No description provided for @christRedeemerVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“The Majestic Statue of Christ the Redeemer - Seven Wonders of the Modern World - See U in History.” Youtube, uploaded by See U in History / Mythology.'**
  String get christRedeemerVideoCaption;

  /// No description provided for @christRedeemerMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Christ the Redeemer in Rio de Janeiro, Brazil.'**
  String get christRedeemerMapCaption;

  /// No description provided for @christRedeemerHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The placement of a Christian monument on Mount Corcovado was first suggested in the mid-1850s to honor Princess Isabel, regent of Brazil and the daughter of Emperor Pedro II, but the project was not approved.\nIn 1889 the country became a republic, and owing to the separation of church and state the proposed statue was dismissed.'**
  String get christRedeemerHistoryInfo1;

  /// No description provided for @christRedeemerHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'The Catholic Circle of Rio made a second proposal for a landmark statue on the mountain in 1920. The group organized an event called Semana do Monumento (\"Monument Week\") to attract donations and collect signatures to support the building of the statue. The organization was motivated by what they perceived as \"Godlessness\" in the society.\nThe designs considered for the \"Statue of the Christ\" included a representation of the Christian cross, a statue of Jesus with a globe in his hands, and a pedestal symbolizing the world.'**
  String get christRedeemerHistoryInfo2;

  /// No description provided for @christRedeemerConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'Artist Carlos Oswald and local engineer Heitor da Silva Costa designed the statue. French sculptor Paul Landowski created the work. In 1922, Landowski commissioned fellow Parisian Romanian sculptor Gheorghe Leonida, who studied sculpture at the Fine Arts Conservatory in Bucharest and in Italy.'**
  String get christRedeemerConstructionInfo1;

  /// No description provided for @christRedeemerConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'A group of engineers and technicians studied Landowski\'s submissions and felt building the structure of reinforced concrete instead of steel was more suitable for the cross-shaped statue. The concrete making up the base was supplied from Limhamn, Sweden. The outer layers are soapstone, chosen for its enduring qualities and ease of use.'**
  String get christRedeemerConstructionInfo2;

  /// No description provided for @christRedeemerLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'Corcovado, which means \"hunchback\" in Portuguese, is a mountain in central Rio de Janeiro, Brazil. It is a 2,329 foot (710 m) granite peak located in the Tijuca Forest, a national park.'**
  String get christRedeemerLocationInfo1;

  /// No description provided for @christRedeemerLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'Corcovado hill lies just west of the city center but is wholly within the city limits and visible from great distances.'**
  String get christRedeemerLocationInfo2;

  /// No description provided for @christRedeemer1850ce.
  ///
  /// In en, this message translates to:
  /// **'Plans for the statue were first proposed by Pedro Maria Boss upon Mount Corcovado. This was never approved, however.'**
  String get christRedeemer1850ce;

  /// No description provided for @christRedeemer1921ce.
  ///
  /// In en, this message translates to:
  /// **'A new plan was proposed by the Roman Catholic archdiocese, and after the citizens of Rio de Janeiro petitioned the president, it was finally approved.'**
  String get christRedeemer1921ce;

  /// No description provided for @christRedeemer1922ce.
  ///
  /// In en, this message translates to:
  /// **'The foundation of the statue was ceremoniously laid out to commemorate Brazil’s independence from Portugal.'**
  String get christRedeemer1922ce;

  /// No description provided for @christRedeemer1926ce.
  ///
  /// In en, this message translates to:
  /// **'Construction officially began after the initial design was chosen via a competition and amended by Brazilian artists and engineers.'**
  String get christRedeemer1926ce;

  /// No description provided for @christRedeemer1931ce.
  ///
  /// In en, this message translates to:
  /// **'Construction of the statue was completed, standing 98’ tall with a 92’ wide arm span.'**
  String get christRedeemer1931ce;

  /// No description provided for @christRedeemer2006ce.
  ///
  /// In en, this message translates to:
  /// **'A chapel was consecrated at the statue’s base to Our Lady of Aparecida to mark the statue’s 75th anniversary.'**
  String get christRedeemer2006ce;

  /// No description provided for @christRedeemerCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Engraved Horn'**
  String get christRedeemerCollectible1Title;

  /// No description provided for @christRedeemerCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'statue'**
  String get christRedeemerCollectible1Icon;

  /// No description provided for @christRedeemerCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Fixed fan'**
  String get christRedeemerCollectible2Title;

  /// No description provided for @christRedeemerCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'jewelry'**
  String get christRedeemerCollectible2Icon;

  /// No description provided for @christRedeemerCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Handkerchiefs (one of two)'**
  String get christRedeemerCollectible3Title;

  /// No description provided for @christRedeemerCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'textile'**
  String get christRedeemerCollectible3Icon;

  /// No description provided for @colosseumTitle.
  ///
  /// In en, this message translates to:
  /// **'Colosseum'**
  String get colosseumTitle;

  /// No description provided for @colosseumSubTitle.
  ///
  /// In en, this message translates to:
  /// **'The icon of Rome'**
  String get colosseumSubTitle;

  /// No description provided for @colosseumRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Rome, Italy'**
  String get colosseumRegionTitle;

  /// No description provided for @colosseumArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Roman'**
  String get colosseumArtifactCulture;

  /// No description provided for @colosseumArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'Roman Empire'**
  String get colosseumArtifactGeolocation;

  /// No description provided for @colosseumPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'Still the Largest Standing'**
  String get colosseumPullQuote1Top;

  /// No description provided for @colosseumPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'Amphitheater in the World Today'**
  String get colosseumPullQuote1Bottom;

  /// No description provided for @colosseumPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'When falls the Coliseum, Rome shall fall; And when Rome falls - the World.'**
  String get colosseumPullQuote2;

  /// No description provided for @colosseumPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Lord Byron'**
  String get colosseumPullQuote2Author;

  /// No description provided for @colosseumCallout1.
  ///
  /// In en, this message translates to:
  /// **'It was used for gladiatorial contests and public spectacles including animal hunts, executions, reenactments of famous battles, and dramas based on Roman mythology, and mock sea battles.'**
  String get colosseumCallout1;

  /// No description provided for @colosseumCallout2.
  ///
  /// In en, this message translates to:
  /// **'It is the largest ancient amphitheater ever built, and is still the largest standing amphitheater in the world today, despite its age.'**
  String get colosseumCallout2;

  /// No description provided for @colosseumVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“Ancient Rome 101 | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get colosseumVideoCaption;

  /// No description provided for @colosseumMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Colosseum in Rome, Italy,'**
  String get colosseumMapCaption;

  /// No description provided for @colosseumHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The Colosseum is an oval amphitheater in the center of the city of Rome, Italy. Unlike Roman theaters that were built into hillsides, the Colosseum is an entirely free-standing structure.'**
  String get colosseumHistoryInfo1;

  /// No description provided for @colosseumHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'The building ceased to be used for entertainment in the early medieval era. By the late 6th century a small chapel had been built into the structure of the amphitheater, and the arena was converted into a cemetery. \nThe numerous vaulted spaces in the arcades under the seating were converted into housing and workshops, and are recorded as still being rented out as late as the 12th century.'**
  String get colosseumHistoryInfo2;

  /// No description provided for @colosseumConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'Construction began under the emperor Vespasian (r. 69-79 CE) in 72 and was completed in 80 CE under his successor and heir, Titus (r. 79-81). Further modifications were made during the reign of Domitian (r. 81-96).\nThe Colosseum is built of travertine limestone, tuff (volcanic rock), and brick-faced concrete. The outer wall is estimated to have required over 3.5 million cubic feet of travertine stone which were set without mortar; they were held together by 300 tons of iron clamps.'**
  String get colosseumConstructionInfo1;

  /// No description provided for @colosseumConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'It could hold an estimated 50,000 to 80,000 spectators at various points in its history, having an average audience of some 65,000.'**
  String get colosseumConstructionInfo2;

  /// No description provided for @colosseumLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'Following the Great Fire of Rome in 64 CE, Emperor Nero seized much of the destroyed area to build his grandiose Domus Aurea (\"Golden House\"). A severe embarrassment to Nero\'s successors, parts of this extravagant palace and grounds, encompassing 1 sq mile, were filled with earth and built over.'**
  String get colosseumLocationInfo1;

  /// No description provided for @colosseumLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'On the site of the lake, in the middle of the palace grounds, Emperor Vespasian would build the Colosseum as part of a Roman resurgence.'**
  String get colosseumLocationInfo2;

  /// No description provided for @colosseum70ce.
  ///
  /// In en, this message translates to:
  /// **'Colosseum construction was started during the Vespasian reign overtop what used to be a private lake for the previous four emperors. This was done in an attempt to revitalize Rome from their tyrannical reign.'**
  String get colosseum70ce;

  /// No description provided for @colosseum82ce.
  ///
  /// In en, this message translates to:
  /// **'The uppermost floor was built, and the structure was officially completed by Domitian.'**
  String get colosseum82ce;

  /// No description provided for @colosseum1140ce.
  ///
  /// In en, this message translates to:
  /// **'The arena was repurposed as a fortress for the Frangipane and Annibaldi families. It was also at one point used as a church.'**
  String get colosseum1140ce;

  /// No description provided for @colosseum1490ce.
  ///
  /// In en, this message translates to:
  /// **'Pope Alexander VI permitted the site to be used as a quarry, for both storing and salvaging building materials.'**
  String get colosseum1490ce;

  /// No description provided for @colosseum1829ce.
  ///
  /// In en, this message translates to:
  /// **'Preservation of the colosseum officially began, after more than a millennia of dilapidation and vandalism. Pope Pius VIII was notably devoted to this project.'**
  String get colosseum1829ce;

  /// No description provided for @colosseum1990ce.
  ///
  /// In en, this message translates to:
  /// **'A restoration project was undertaken to ensure the colosseum remained a major tourist attraction for Rome. It currently stands as one of the greatest sources of tourism revenue in Italy.'**
  String get colosseum1990ce;

  /// No description provided for @colosseumCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Glass hexagonal amphoriskos'**
  String get colosseumCollectible1Title;

  /// No description provided for @colosseumCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'vase'**
  String get colosseumCollectible1Icon;

  /// No description provided for @colosseumCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Bronze plaque of Mithras slaying the bull'**
  String get colosseumCollectible2Title;

  /// No description provided for @colosseumCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'statue'**
  String get colosseumCollectible2Icon;

  /// No description provided for @colosseumCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Interno del Colosseo'**
  String get colosseumCollectible3Title;

  /// No description provided for @colosseumCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'picture'**
  String get colosseumCollectible3Icon;

  /// No description provided for @greatWallTitle.
  ///
  /// In en, this message translates to:
  /// **'The Great Wall'**
  String get greatWallTitle;

  /// No description provided for @greatWallSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Longest structure on Earth'**
  String get greatWallSubTitle;

  /// No description provided for @greatWallRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get greatWallRegionTitle;

  /// No description provided for @greatWallArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get greatWallArtifactCulture;

  /// No description provided for @greatWallArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get greatWallArtifactGeolocation;

  /// No description provided for @greatWallPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'The Longest Man-Made'**
  String get greatWallPullQuote1Top;

  /// No description provided for @greatWallPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'Structure in the World'**
  String get greatWallPullQuote1Bottom;

  /// No description provided for @greatWallPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'Its historic and strategic importance is matched only by its architectural significance.'**
  String get greatWallPullQuote2;

  /// No description provided for @greatWallPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'UNESCO'**
  String get greatWallPullQuote2Author;

  /// No description provided for @greatWallCallout1.
  ///
  /// In en, this message translates to:
  /// **'The best-known sections of the wall were built by the Ming dynasty (1368-1644).'**
  String get greatWallCallout1;

  /// No description provided for @greatWallCallout2.
  ///
  /// In en, this message translates to:
  /// **'During the Ming dynasty, however, bricks were heavily used in many areas of the wall, as were materials such as tiles, lime, and stone.'**
  String get greatWallCallout2;

  /// No description provided for @greatWallVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“See China’s Iconic Great Wall From Above | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get greatWallVideoCaption;

  /// No description provided for @greatWallMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Great Wall of China in northern China.'**
  String get greatWallMapCaption;

  /// No description provided for @greatWallHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. The total length of all sections ever built is over 13,000 miles.'**
  String get greatWallHistoryInfo1;

  /// No description provided for @greatWallHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'Several walls were built from as early as the 7th century BCE, with selective stretches later joined together by Qin Shi Huang (220-206  BCE), the first emperor of China. Little of the Qin wall remains. \nLater on, many successive dynasties built and maintained multiple stretches of border walls.'**
  String get greatWallHistoryInfo2;

  /// No description provided for @greatWallConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'Transporting the large quantity of materials required for construction was difficult, so builders always tried to use local resources. Stones from the mountains were used over mountain ranges, while rammed earth was used for construction in the plains. Most of the ancient walls have eroded away over the centuries.'**
  String get greatWallConstructionInfo1;

  /// No description provided for @greatWallConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'Stones cut into rectangular shapes were used for the foundation, inner and outer brims, and gateways of the wall. \nUnder the rule of the Qing dynasty, China\'s borders extended beyond the walls and Mongolia was annexed into the empire, so construction was discontinued.'**
  String get greatWallConstructionInfo2;

  /// No description provided for @greatWallLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'The frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino-Russian border in the north to Tao River in the south; along an arc that roughly delineates the edge of the Mongolian steppe.'**
  String get greatWallLocationInfo1;

  /// No description provided for @greatWallLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'Apart from defense, other purposes of the Great Wall have included border controls, allowing the imposition of duties on goods transported along the Silk Road, regulation or encouragement of trade and the control of immigration and emigration.'**
  String get greatWallLocationInfo2;

  /// No description provided for @greatWall700bce.
  ///
  /// In en, this message translates to:
  /// **'First landmark of the Great Wall began originally as a square wall surrounding the state of Chu. Over the years, additional walls would be built and added to it to expand and connect territory.'**
  String get greatWall700bce;

  /// No description provided for @greatWall214bce.
  ///
  /// In en, this message translates to:
  /// **'The first Qin Emperor unifies China and links the wall of the surrounding states of Qin, Yan, and Zhao into the Great Wall of China, taking 10 years to build with hundreds of thousands of laborers.'**
  String get greatWall214bce;

  /// No description provided for @greatWall121bce.
  ///
  /// In en, this message translates to:
  /// **'A 20-year construction project was started by the Han emperor to build east and west sections of the wall, including beacons, towers, and castles. Not just for defense, but also to control trade routes like the Silk Road.'**
  String get greatWall121bce;

  /// No description provided for @greatWall556ce.
  ///
  /// In en, this message translates to:
  /// **'The Bei Qi kingdom also launched several construction projects, utilizing over 1.8 million workers to repair and extend sections of the wall, adding to its length and even building a second inner wall around Shanxi.'**
  String get greatWall556ce;

  /// No description provided for @greatWall618ce.
  ///
  /// In en, this message translates to:
  /// **'The Great Wall was repaired during the Sui Dynasty and used to defend against Tujue attacks. Before and after the Sui Dynasty, the wall saw very little use and fell into disrepair.'**
  String get greatWall618ce;

  /// No description provided for @greatWall1487ce.
  ///
  /// In en, this message translates to:
  /// **'Hongzhi Emperor split the walls into north and south lines, eventually shaping it into how it is today. Since then, it has gradually fallen into disrepair and remains mostly unused.'**
  String get greatWall1487ce;

  /// No description provided for @greatWallCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Biographies of Lian Po and Lin Xiangru'**
  String get greatWallCollectible1Title;

  /// No description provided for @greatWallCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'scroll'**
  String get greatWallCollectible1Icon;

  /// No description provided for @greatWallCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Jar with Dragon'**
  String get greatWallCollectible2Title;

  /// No description provided for @greatWallCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'vase'**
  String get greatWallCollectible2Icon;

  /// No description provided for @greatWallCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Panel with Peonies and Butterfly'**
  String get greatWallCollectible3Title;

  /// No description provided for @greatWallCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'textile'**
  String get greatWallCollectible3Icon;

  /// No description provided for @machuPicchuTitle.
  ///
  /// In en, this message translates to:
  /// **'Machu Picchu'**
  String get machuPicchuTitle;

  /// No description provided for @machuPicchuSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Citadel of the Inca'**
  String get machuPicchuSubTitle;

  /// No description provided for @machuPicchuRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Cusco Region, Peru'**
  String get machuPicchuRegionTitle;

  /// No description provided for @machuPicchuArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Inca'**
  String get machuPicchuArtifactCulture;

  /// No description provided for @machuPicchuArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'South America'**
  String get machuPicchuArtifactGeolocation;

  /// No description provided for @machuPicchuPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'Few Romances Can Ever Surpass'**
  String get machuPicchuPullQuote1Top;

  /// No description provided for @machuPicchuPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'That of the Granite Citadel'**
  String get machuPicchuPullQuote1Bottom;

  /// No description provided for @machuPicchuPullQuote1Author.
  ///
  /// In en, this message translates to:
  /// **'Hiram Bingham'**
  String get machuPicchuPullQuote1Author;

  /// No description provided for @machuPicchuPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'In the variety of its charms and the power of its spell, I know of no other place in the world which can compare with it.'**
  String get machuPicchuPullQuote2;

  /// No description provided for @machuPicchuPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Hiram Bingham'**
  String get machuPicchuPullQuote2Author;

  /// No description provided for @machuPicchuCallout1.
  ///
  /// In en, this message translates to:
  /// **'During its use as a royal estate, it is estimated that about 750 people lived there, with most serving as support staff who lived there permanently.'**
  String get machuPicchuCallout1;

  /// No description provided for @machuPicchuCallout2.
  ///
  /// In en, this message translates to:
  /// **'The Incas were masters of this technique, called ashlar, in which blocks of stone are cut to fit together tightly without mortar.'**
  String get machuPicchuCallout2;

  /// No description provided for @machuPicchuVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“Machu Picchu 101 | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get machuPicchuVideoCaption;

  /// No description provided for @machuPicchuMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Machu Picchu in the Eastern Cordillera of southern Peru.'**
  String get machuPicchuMapCaption;

  /// No description provided for @machuPicchuHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru on a 2,430-meter (7,970 ft) mountain ridge. Construction appears to date from two great Inca rulers, Pachacutec Inca Yupanqui (1438–1471 CE) and Túpac Inca Yupanqui (1472–1493 CE).'**
  String get machuPicchuHistoryInfo1;

  /// No description provided for @machuPicchuHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'There is a consensus among archeologists that Pachacutec ordered the construction of the royal estate for his use as a retreat, most likely after a successful military campaign.\nRather it was used for 80 years before being abandoned, seemingly because of the Spanish conquests in other parts of the Inca Empire.'**
  String get machuPicchuHistoryInfo2;

  /// No description provided for @machuPicchuConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'The central buildings use the classical Inca architectural style of polished dry-stone walls of regular shape. \nInca walls have many stabilizing features: doors and windows are trapezoidal, narrowing from bottom to top; corners usually are rounded; inside corners often incline slightly into the rooms, and outside corners were often tied together by \"L\"-shaped blocks.'**
  String get machuPicchuConstructionInfo1;

  /// No description provided for @machuPicchuConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'This precision construction method made the structures at Machu Picchu resistant to seismic activity.\nThe site itself may have been intentionally built on fault lines to afford better drainage and a ready supply of fractured stone.'**
  String get machuPicchuConstructionInfo2;

  /// No description provided for @machuPicchuLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'Machu Picchu is situated above a bow of the Urubamba River, which surrounds the site on three sides, where cliffs drop vertically for 1,480 feet (450 m) to the river at their base. The location of the city was a military secret, and its deep precipices and steep mountains provided natural defenses.'**
  String get machuPicchuLocationInfo1;

  /// No description provided for @machuPicchuLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'The Inca Bridge, an Inca grass rope bridge, across the Urubamba River in the Pongo de Mainique, provided a secret entrance for the Inca army. Another Inca bridge was built to the west of Machu Picchu, the tree-trunk bridge, at a location where a gap occurs in the cliff that measures 20 feet (6 m).'**
  String get machuPicchuLocationInfo2;

  /// No description provided for @machuPicchu1438ce.
  ///
  /// In en, this message translates to:
  /// **'Speculated to be built and occupied by Inca ruler Pachacuti Inca Yupanqui.'**
  String get machuPicchu1438ce;

  /// No description provided for @machuPicchu1572ce.
  ///
  /// In en, this message translates to:
  /// **'The last Inca rulers used the site as a bastion to rebel against Spanish rule until they were ultimately wiped out.'**
  String get machuPicchu1572ce;

  /// No description provided for @machuPicchu1867ce.
  ///
  /// In en, this message translates to:
  /// **'Speculated to have been originally discovered by German explorer Augusto Berns, but his findings were never effectively publicized.'**
  String get machuPicchu1867ce;

  /// No description provided for @machuPicchu1911ce.
  ///
  /// In en, this message translates to:
  /// **'Introduced to the world by Hiram Bingham of Yale University, who was led there by locals after disclosing he was searching for Vilcabamba, the ’lost city of the Incas’.'**
  String get machuPicchu1911ce;

  /// No description provided for @machuPicchu1964ce.
  ///
  /// In en, this message translates to:
  /// **'Surrounding sites were excavated thoroughly by Gene Savoy, who found a much more suitable candidate for Vilcabamba in the ruin known as Espíritu Pampa.'**
  String get machuPicchu1964ce;

  /// No description provided for @machuPicchu1997ce.
  ///
  /// In en, this message translates to:
  /// **'Since its rediscovery, growing numbers of tourists have visited the Machu Picchu each year, with numbers exceeding 1.4 million in 2017.'**
  String get machuPicchu1997ce;

  /// No description provided for @machuPicchuCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Eight-Pointed Star Tunic'**
  String get machuPicchuCollectible1Title;

  /// No description provided for @machuPicchuCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'textile'**
  String get machuPicchuCollectible1Icon;

  /// No description provided for @machuPicchuCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Camelid figurine'**
  String get machuPicchuCollectible2Title;

  /// No description provided for @machuPicchuCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'statue'**
  String get machuPicchuCollectible2Icon;

  /// No description provided for @machuPicchuCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Double Bowl'**
  String get machuPicchuCollectible3Title;

  /// No description provided for @machuPicchuCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'vase'**
  String get machuPicchuCollectible3Icon;

  /// No description provided for @petraTitle.
  ///
  /// In en, this message translates to:
  /// **'Petra'**
  String get petraTitle;

  /// No description provided for @petraSubTitle.
  ///
  /// In en, this message translates to:
  /// **'The Lost City'**
  String get petraSubTitle;

  /// No description provided for @petraRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Ma’an, Jordan'**
  String get petraRegionTitle;

  /// No description provided for @petraArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Nabataean'**
  String get petraArtifactCulture;

  /// No description provided for @petraArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'Levant'**
  String get petraArtifactGeolocation;

  /// No description provided for @petraPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'A Rose-Red City'**
  String get petraPullQuote1Top;

  /// No description provided for @petraPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'Half as Old as Time'**
  String get petraPullQuote1Bottom;

  /// No description provided for @petraPullQuote1Author.
  ///
  /// In en, this message translates to:
  /// **'John William Burgon'**
  String get petraPullQuote1Author;

  /// No description provided for @petraPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'Petra is a brilliant display of man’s artistry in turning barren rock into a majestic wonder.'**
  String get petraPullQuote2;

  /// No description provided for @petraPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Edward Dawson'**
  String get petraPullQuote2Author;

  /// No description provided for @petraCallout1.
  ///
  /// In en, this message translates to:
  /// **'They were particularly skillful in harvesting rainwater, agriculture and stone carving.'**
  String get petraCallout1;

  /// No description provided for @petraCallout2.
  ///
  /// In en, this message translates to:
  /// **'Perhaps a more prominent resemblance to Hellenistic style in Petra comes with its Treasury.'**
  String get petraCallout2;

  /// No description provided for @petraVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“Stunning Stone Monuments of Petra | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get petraVideoCaption;

  /// No description provided for @petraMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Petra in Ma’an Governorate, Jordan.'**
  String get petraMapCaption;

  /// No description provided for @petraHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The area around Petra has been inhabited from as early as 7000  BCE, and the Nabataeans might have settled in what would become the capital city of their kingdom as early as the 4th century BCE.\nThe trading business gained the Nabataeans considerable revenue and Petra became the focus of their wealth. The Nabataeans were accustomed to living in the barren deserts, unlike their enemies, and were able to repel attacks by taking advantage of the area\'s mountainous terrain.'**
  String get petraHistoryInfo1;

  /// No description provided for @petraHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'Petra flourished in the 1st century CE, when its famous Al-Khazneh structure - believed to be the mausoleum of Nabataean king Aretas IV - was constructed, and its population peaked at an estimated 20,000 inhabitants.\nAccess to the city is through a 3/4 mile-long (1.2 km) gorge called the Siq, which leads directly to the Khazneh.'**
  String get petraHistoryInfo2;

  /// No description provided for @petraConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'Famous for its rock-cut architecture and water conduit system, Petra is also called the \"Red Rose City\" because of the color of the stone from which it is carved.\nAnother thing Petra is known for is its Hellenistic (“Greek”) architecture. These influences can be seen in many of the facades at Petra and are a reflection of the cultures that the Nabataens traded with.'**
  String get petraConstructionInfo1;

  /// No description provided for @petraConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'The facade of the Treasury features a broken pediment with a central tholos (“dome”) inside, and two obelisks appear to form into the rock of Petra at the top. Near the bottom of the Treasury we see twin Greek Gods: Pollux, Castor, and Dioscuri, who protect travelers on their journeys. \nNear the top of the Treasury, two victories are seen standing on each side of a female figure on the tholos. This female figure is believed to be the Isis-Tyche, Isis being the Egyptian Goddess and Tyche being the Greek Goddess of good fortune.'**
  String get petraConstructionInfo2;

  /// No description provided for @petraLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'Petra is located in southern Jordan. It is adjacent to the mountain of Jabal Al-Madbah, in a basin surrounded by mountains forming the eastern flank of the Arabah valley running from the Dead Sea to the Gulf of Aqaba.'**
  String get petraLocationInfo1;

  /// No description provided for @petraLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'The area around Petra has been inhabited from as early as 7000 BC, and the Nabataeans might have settled in what would become the capital city of their kingdom as early as the 4th century BC.\nArchaeological work has only discovered evidence of Nabataean presence dating back to the second century BC, by which time Petra had become their capital. The Nabataeans were nomadic Arabs who invested in Petra\'s proximity to the incense trade routes by establishing it as a major regional trading hub.'**
  String get petraLocationInfo2;

  /// No description provided for @petra1200bce.
  ///
  /// In en, this message translates to:
  /// **'First Edomites occupied the area and established a foothold.'**
  String get petra1200bce;

  /// No description provided for @petra106bce.
  ///
  /// In en, this message translates to:
  /// **'Became part of the Roman province Arabia'**
  String get petra106bce;

  /// No description provided for @petra551ce.
  ///
  /// In en, this message translates to:
  /// **'After being damaged by earthquakes, habitation of the city all but ceased.'**
  String get petra551ce;

  /// No description provided for @petra1812ce.
  ///
  /// In en, this message translates to:
  /// **'Rediscovered by the Swiss traveler Johann Ludwig Burckhardt.'**
  String get petra1812ce;

  /// No description provided for @petra1958ce.
  ///
  /// In en, this message translates to:
  /// **'Excavations led on the site by the British School of Archaeology and the American Center of Oriental Research.'**
  String get petra1958ce;

  /// No description provided for @petra1989ce.
  ///
  /// In en, this message translates to:
  /// **'Appeared in the film Indiana Jones and The Last Crusade.'**
  String get petra1989ce;

  /// No description provided for @petraCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Camel and riders'**
  String get petraCollectible1Title;

  /// No description provided for @petraCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'statue'**
  String get petraCollectible1Icon;

  /// No description provided for @petraCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Vessel'**
  String get petraCollectible2Title;

  /// No description provided for @petraCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'vase'**
  String get petraCollectible2Icon;

  /// No description provided for @petraCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Open bowl'**
  String get petraCollectible3Title;

  /// No description provided for @petraCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'vase'**
  String get petraCollectible3Icon;

  /// No description provided for @pyramidsGizaTitle.
  ///
  /// In en, this message translates to:
  /// **'Pyramids of Giza'**
  String get pyramidsGizaTitle;

  /// No description provided for @pyramidsGizaSubTitle.
  ///
  /// In en, this message translates to:
  /// **'The ancient wonder'**
  String get pyramidsGizaSubTitle;

  /// No description provided for @pyramidsGizaRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get pyramidsGizaRegionTitle;

  /// No description provided for @pyramidsGizaArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get pyramidsGizaArtifactCulture;

  /// No description provided for @pyramidsGizaArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get pyramidsGizaArtifactGeolocation;

  /// No description provided for @pyramidsGizaPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'The Tallest Structures on Earth'**
  String get pyramidsGizaPullQuote1Top;

  /// No description provided for @pyramidsGizaPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'Until the Advent of Modern Skyscrapers'**
  String get pyramidsGizaPullQuote1Bottom;

  /// No description provided for @pyramidsGizaPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'From the heights of these pyramids, forty centuries look down on us.'**
  String get pyramidsGizaPullQuote2;

  /// No description provided for @pyramidsGizaPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Napoleon Bonaparte'**
  String get pyramidsGizaPullQuote2Author;

  /// No description provided for @pyramidsGizaCallout1.
  ///
  /// In en, this message translates to:
  /// **'It is theorized the pyramid not only served as a tomb for the pharaoh, but also as a storage pit for various items he would need in the afterlife.'**
  String get pyramidsGizaCallout1;

  /// No description provided for @pyramidsGizaCallout2.
  ///
  /// In en, this message translates to:
  /// **'The Great Pyramid consists of an estimated 2.3 million blocks. Approximately 5.5 million tonnes of limestone, 8,000 tonnes of granite, and 500,000 tonnes of mortar were used in the construction.'**
  String get pyramidsGizaCallout2;

  /// No description provided for @pyramidsGizaVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“The Great Pyramids of Giza | Egypt’s Ancient Mysteries | National Geographic UK.” Youtube, uploaded by National Geographic UK.'**
  String get pyramidsGizaVideoCaption;

  /// No description provided for @pyramidsGizaMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Giza Pyramids in Greater Cairo, Egypt.'**
  String get pyramidsGizaMapCaption;

  /// No description provided for @pyramidsGizaHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The Giza pyramid complex, also called the Giza necropolis, is the site on the Giza Plateau in Greater Cairo, Egypt that includes the Great Pyramid of Giza, the Pyramid of Khafre, and the Pyramid of Menkaure, along with their associated pyramid complexes and the Great Sphinx of Giza. All were built during the Fourth Dynasty of the Old Kingdom of Ancient Egypt, between 2600 and 2500 BCE.'**
  String get pyramidsGizaHistoryInfo1;

  /// No description provided for @pyramidsGizaHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'The pyramids of Giza and others are thought to have been constructed to house the remains of the deceased pharaohs who ruled over Ancient Egypt. A portion of the pharaoh\'s spirit called his ka was believed to remain with his corpse. Proper care of the remains was necessary in order for the former Pharaoh to perform his new duties as king of the dead.'**
  String get pyramidsGizaHistoryInfo2;

  /// No description provided for @pyramidsGizaConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'Most construction theories are based on the idea that the pyramids were built by moving huge stones from a quarry and dragging and lifting them into place. In building the pyramids, the architects might have developed their techniques over time.\nThey would select a site on a relatively flat area of bedrock — not sand — which provided a stable foundation. After carefully surveying the site and laying down the first level of stones, they constructed the pyramids in horizontal levels, one on top of the other.'**
  String get pyramidsGizaConstructionInfo1;

  /// No description provided for @pyramidsGizaConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'For the Great Pyramid, most of the stone for the interior seems to have been quarried immediately to the south of the construction site. The smooth exterior of the pyramid was made of a fine grade of white limestone that was quarried across the Nile.\nTo ensure that the pyramid remained symmetrical, the exterior casing stones all had to be equal in height and width. Workers might have marked all the blocks to indicate the angle of the pyramid wall and trimmed the surfaces carefully so that the blocks fit together. During construction, the outer surface of the stone was smooth limestone; excess stone has eroded as time has passed.'**
  String get pyramidsGizaConstructionInfo2;

  /// No description provided for @pyramidsGizaLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'The site is at the edges of the Western Desert, approximately 5.6 miles (9 km) west of the Nile River in the city of Giza, and about 8 miles (13 km) southwest of the city center of Cairo.'**
  String get pyramidsGizaLocationInfo1;

  /// No description provided for @pyramidsGizaLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'Currently, the pyramids are located in the northwestern side of the Western Desert, and it is considered to be one of the best recognizable and the most visited tourist attractions of the planet.'**
  String get pyramidsGizaLocationInfo2;

  /// No description provided for @pyramidsGiza2575bce.
  ///
  /// In en, this message translates to:
  /// **'Construction of the 3 pyramids began for three kings of the 4th dynasty; Khufu, Khafre, and Menkaure.'**
  String get pyramidsGiza2575bce;

  /// No description provided for @pyramidsGiza2465bce.
  ///
  /// In en, this message translates to:
  /// **'Construction began on the smaller surrounding structures called Mastabas for royalty of the 5th and 6th dynasties.'**
  String get pyramidsGiza2465bce;

  /// No description provided for @pyramidsGiza443bce.
  ///
  /// In en, this message translates to:
  /// **'Greek Author Herodotus speculated that the pyramids were built in the span of 20 years with over 100,000 slave labourers. This assumption would last for over 1500 years'**
  String get pyramidsGiza443bce;

  /// No description provided for @pyramidsGiza1925ce.
  ///
  /// In en, this message translates to:
  /// **'Tomb of Queen Hetepheres was discovered, containing furniture and jewelry. One of the last remaining treasure-filled tombs after many years of looting and plundering.'**
  String get pyramidsGiza1925ce;

  /// No description provided for @pyramidsGiza1979ce.
  ///
  /// In en, this message translates to:
  /// **'Designated a UNESCO World Heritage Site to prevent any more unauthorized plundering and vandalism.'**
  String get pyramidsGiza1979ce;

  /// No description provided for @pyramidsGiza1990ce.
  ///
  /// In en, this message translates to:
  /// **'Discovery of labouror’s districts suggest that the workers building the pyramids were not slaves, and an ingenious building method proved a relatively small work-force was required to build such immense structures.'**
  String get pyramidsGiza1990ce;

  /// No description provided for @pyramidsGizaCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Two papyrus fragments'**
  String get pyramidsGizaCollectible1Title;

  /// No description provided for @pyramidsGizaCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'scroll'**
  String get pyramidsGizaCollectible1Icon;

  /// No description provided for @pyramidsGizaCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'Fragmentary Face of King Khafre'**
  String get pyramidsGizaCollectible2Title;

  /// No description provided for @pyramidsGizaCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'statue'**
  String get pyramidsGizaCollectible2Icon;

  /// No description provided for @pyramidsGizaCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Jewelry Elements'**
  String get pyramidsGizaCollectible3Title;

  /// No description provided for @pyramidsGizaCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'jewelry'**
  String get pyramidsGizaCollectible3Icon;

  /// No description provided for @tajMahalTitle.
  ///
  /// In en, this message translates to:
  /// **'Taj Mahal'**
  String get tajMahalTitle;

  /// No description provided for @tajMahalSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Heaven on Earth'**
  String get tajMahalSubTitle;

  /// No description provided for @tajMahalRegionTitle.
  ///
  /// In en, this message translates to:
  /// **'Agra, India'**
  String get tajMahalRegionTitle;

  /// No description provided for @tajMahalArtifactCulture.
  ///
  /// In en, this message translates to:
  /// **'Mughal'**
  String get tajMahalArtifactCulture;

  /// No description provided for @tajMahalArtifactGeolocation.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get tajMahalArtifactGeolocation;

  /// No description provided for @tajMahalPullQuote1Top.
  ///
  /// In en, this message translates to:
  /// **'Not just a Monument,'**
  String get tajMahalPullQuote1Top;

  /// No description provided for @tajMahalPullQuote1Bottom.
  ///
  /// In en, this message translates to:
  /// **'but a Symbol of Love.'**
  String get tajMahalPullQuote1Bottom;

  /// No description provided for @tajMahalPullQuote1Author.
  ///
  /// In en, this message translates to:
  /// **'Suman Pokhrel'**
  String get tajMahalPullQuote1Author;

  /// No description provided for @tajMahalPullQuote2.
  ///
  /// In en, this message translates to:
  /// **'The Taj Mahal rises above the banks of the river like a solitary tear suspended on the cheek of time.'**
  String get tajMahalPullQuote2;

  /// No description provided for @tajMahalPullQuote2Author.
  ///
  /// In en, this message translates to:
  /// **'Rabindranath Tagore'**
  String get tajMahalPullQuote2Author;

  /// No description provided for @tajMahalCallout1.
  ///
  /// In en, this message translates to:
  /// **'The Taj Mahal is distinguished as the finest example of Mughal architecture, a blend of Indian, Persian, and Islamic styles.'**
  String get tajMahalCallout1;

  /// No description provided for @tajMahalCallout2.
  ///
  /// In en, this message translates to:
  /// **'It took the efforts of 22,000 laborers, painters, embroidery artists and stonecutters to shape the Taj Mahal.'**
  String get tajMahalCallout2;

  /// No description provided for @tajMahalVideoCaption.
  ///
  /// In en, this message translates to:
  /// **'“India’s Taj Mahal Is an Enduring Monument to Love | National Geographic.” Youtube, uploaded by National Geographic.'**
  String get tajMahalVideoCaption;

  /// No description provided for @tajMahalMapCaption.
  ///
  /// In en, this message translates to:
  /// **'Map showing location of Taj Mahal in Uttar Pradesh, India.'**
  String get tajMahalMapCaption;

  /// No description provided for @tajMahalHistoryInfo1.
  ///
  /// In en, this message translates to:
  /// **'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1632 CE by the Mughal emperor Shah Jahan (r. 1628-1658) to house the tomb of his favorite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.'**
  String get tajMahalHistoryInfo1;

  /// No description provided for @tajMahalHistoryInfo2.
  ///
  /// In en, this message translates to:
  /// **'The tomb is the centerpiece of a 42-acre (17-hectare) complex, which include twin mosque buildings (placed symmetrically on either side of the mausoleum), a guest house, and is set in formal gardens bounded on three sides by walls.'**
  String get tajMahalHistoryInfo2;

  /// No description provided for @tajMahalConstructionInfo1.
  ///
  /// In en, this message translates to:
  /// **'The Taj Mahal was constructed using materials from all over India and Asia. It is believed over 1,000 elephants were used to transport building materials.\nThe translucent white marble was brought from Rajasthan, the jasper from Punjab, jade and crystal from China. The turquoise was from Tibet and the lapis from Afghanistan, while the sapphire came from Sri Lanka. In all, twenty-eight types of precious and semi-precious stones were inlaid into the white marble.'**
  String get tajMahalConstructionInfo1;

  /// No description provided for @tajMahalConstructionInfo2.
  ///
  /// In en, this message translates to:
  /// **'An area of roughly 3 acres was excavated, filled with dirt to reduce seepage, and leveled at 160 ft above riverbank. In the tomb area, wells were dug and filled with stone and rubble to form the footings of the tomb.\nThe plinth and tomb took roughly 12 years to complete. The remaining parts of the complex took an additional 10 years.'**
  String get tajMahalConstructionInfo2;

  /// No description provided for @tajMahalLocationInfo1.
  ///
  /// In en, this message translates to:
  /// **'India\'s most famed building, it is situated in the eastern part of the city on the southern bank of the Yamuna River, nearly 1 mile east of the Agra Fort, also on the right bank of the Yamuna.'**
  String get tajMahalLocationInfo1;

  /// No description provided for @tajMahalLocationInfo2.
  ///
  /// In en, this message translates to:
  /// **'The Taj Mahal is built on a parcel of land to the south of the walled city of Agra. Shah Jahan presented Maharaja Jai Singh with a large palace in the center of Agra in exchange for the land.'**
  String get tajMahalLocationInfo2;

  /// No description provided for @tajMahal1631ce.
  ///
  /// In en, this message translates to:
  /// **'Built by Mughal Emperor Shah Jahān to immortalize his deceased wife.'**
  String get tajMahal1631ce;

  /// No description provided for @tajMahal1647ce.
  ///
  /// In en, this message translates to:
  /// **'Construction completed. The project involved over 20,000 workers and spanned 42 acres.'**
  String get tajMahal1647ce;

  /// No description provided for @tajMahal1658ce.
  ///
  /// In en, this message translates to:
  /// **'There were plans for a second mausoleum for his own remains, but Shah Jahān was imprisoned by his son for the rest of his life in Agra Fort, and this never came to pass.'**
  String get tajMahal1658ce;

  /// No description provided for @tajMahal1901ce.
  ///
  /// In en, this message translates to:
  /// **'Lord Curzon and the British Viceroy of India carried out a major restoration to the monument after over 350 years of decay and corrosion due to factory pollution and exhaust.'**
  String get tajMahal1901ce;

  /// No description provided for @tajMahal1984ce.
  ///
  /// In en, this message translates to:
  /// **'To protect the structure from Sikh militants and some Hindu nationalist groups, night viewing was banned to tourists. This ban would last 20 years.'**
  String get tajMahal1984ce;

  /// No description provided for @tajMahal1998ce.
  ///
  /// In en, this message translates to:
  /// **'Restoration and research program put into action to help preserve the monument.'**
  String get tajMahal1998ce;

  /// No description provided for @tajMahalCollectible1Title.
  ///
  /// In en, this message translates to:
  /// **'Dagger with Scabbard'**
  String get tajMahalCollectible1Title;

  /// No description provided for @tajMahalCollectible1Icon.
  ///
  /// In en, this message translates to:
  /// **'jewelry'**
  String get tajMahalCollectible1Icon;

  /// No description provided for @tajMahalCollectible2Title.
  ///
  /// In en, this message translates to:
  /// **'The House of Bijapur'**
  String get tajMahalCollectible2Title;

  /// No description provided for @tajMahalCollectible2Icon.
  ///
  /// In en, this message translates to:
  /// **'picture'**
  String get tajMahalCollectible2Icon;

  /// No description provided for @tajMahalCollectible3Title.
  ///
  /// In en, this message translates to:
  /// **'Panel of Nasta\'liq Calligraphy'**
  String get tajMahalCollectible3Title;

  /// No description provided for @tajMahalCollectible3Icon.
  ///
  /// In en, this message translates to:
  /// **'scroll'**
  String get tajMahalCollectible3Icon;

  /// No description provided for @timelineEvent2900bce.
  ///
  /// In en, this message translates to:
  /// **'First known use of papyrus by Egyptians'**
  String get timelineEvent2900bce;

  /// No description provided for @timelineEvent2700bce.
  ///
  /// In en, this message translates to:
  /// **'The Old Kingdom begins in Egypt'**
  String get timelineEvent2700bce;

  /// No description provided for @timelineEvent2600bce.
  ///
  /// In en, this message translates to:
  /// **'Emergence of Mayan culture in the Yucatán Peninsula'**
  String get timelineEvent2600bce;

  /// No description provided for @timelineEvent2560bce.
  ///
  /// In en, this message translates to:
  /// **'King Khufu completes the Great Pyramid of Giza'**
  String get timelineEvent2560bce;

  /// No description provided for @timelineEvent2500bce.
  ///
  /// In en, this message translates to:
  /// **'The mammoth goes extinct'**
  String get timelineEvent2500bce;

  /// No description provided for @timelineEvent2200bce.
  ///
  /// In en, this message translates to:
  /// **'Completion of Stonehenge'**
  String get timelineEvent2200bce;

  /// No description provided for @timelineEvent2000bce.
  ///
  /// In en, this message translates to:
  /// **'Domestication of the horse'**
  String get timelineEvent2000bce;

  /// No description provided for @timelineEvent1800bce.
  ///
  /// In en, this message translates to:
  /// **'Alphabetic writing emerges'**
  String get timelineEvent1800bce;

  /// No description provided for @timelineEvent890bce.
  ///
  /// In en, this message translates to:
  /// **'Homer writes the Iliad and the Odyssey'**
  String get timelineEvent890bce;

  /// No description provided for @timelineEvent776bce.
  ///
  /// In en, this message translates to:
  /// **'First recorded Ancient Olympic Games'**
  String get timelineEvent776bce;

  /// No description provided for @timelineEvent753bce.
  ///
  /// In en, this message translates to:
  /// **'Founding of Rome'**
  String get timelineEvent753bce;

  /// No description provided for @timelineEvent447bce.
  ///
  /// In en, this message translates to:
  /// **'Building of the Parthenon at Athens started'**
  String get timelineEvent447bce;

  /// No description provided for @timelineEvent427bce.
  ///
  /// In en, this message translates to:
  /// **'Birth of Greek Philosopher Plato'**
  String get timelineEvent427bce;

  /// No description provided for @timelineEvent322bce.
  ///
  /// In en, this message translates to:
  /// **'Death of Aristotle (61), the first genuine scientist'**
  String get timelineEvent322bce;

  /// No description provided for @timelineEvent200bce.
  ///
  /// In en, this message translates to:
  /// **'Paper is invented in the Han Dynasty'**
  String get timelineEvent200bce;

  /// No description provided for @timelineEvent44bce.
  ///
  /// In en, this message translates to:
  /// **'Death of Julius Caesar; beginning of the Roman Empire'**
  String get timelineEvent44bce;

  /// No description provided for @timelineEvent4bce.
  ///
  /// In en, this message translates to:
  /// **'Birth of Jesus Christ'**
  String get timelineEvent4bce;

  /// No description provided for @timelineEvent43ce.
  ///
  /// In en, this message translates to:
  /// **'The Roman Empire enters Great Britain for the first time'**
  String get timelineEvent43ce;

  /// No description provided for @timelineEvent79ce.
  ///
  /// In en, this message translates to:
  /// **'Destruction of Pompeii by the volcano Vesuvius'**
  String get timelineEvent79ce;

  /// No description provided for @timelineEvent455ce.
  ///
  /// In en, this message translates to:
  /// **'End of the Roman Empire'**
  String get timelineEvent455ce;

  /// No description provided for @timelineEvent500ce.
  ///
  /// In en, this message translates to:
  /// **'Tikal becomes the first great Maya city'**
  String get timelineEvent500ce;

  /// No description provided for @timelineEvent632ce.
  ///
  /// In en, this message translates to:
  /// **'Death of Muhammad (61), founder of Islam'**
  String get timelineEvent632ce;

  /// No description provided for @timelineEvent793ce.
  ///
  /// In en, this message translates to:
  /// **'The Vikings first invade Britain'**
  String get timelineEvent793ce;

  /// No description provided for @timelineEvent800ce.
  ///
  /// In en, this message translates to:
  /// **'Gunpowder is invented in China'**
  String get timelineEvent800ce;

  /// No description provided for @timelineEvent1001ce.
  ///
  /// In en, this message translates to:
  /// **'Leif Erikson settles during the winter in present-day eastern Canada'**
  String get timelineEvent1001ce;

  /// No description provided for @timelineEvent1077ce.
  ///
  /// In en, this message translates to:
  /// **'The Construction of the Tower of London begins'**
  String get timelineEvent1077ce;

  /// No description provided for @timelineEvent1117ce.
  ///
  /// In en, this message translates to:
  /// **'The University of Oxford is founded'**
  String get timelineEvent1117ce;

  /// No description provided for @timelineEvent1199ce.
  ///
  /// In en, this message translates to:
  /// **'Europeans first use compasses'**
  String get timelineEvent1199ce;

  /// No description provided for @timelineEvent1227ce.
  ///
  /// In en, this message translates to:
  /// **'Death of Genghis Khan (65)'**
  String get timelineEvent1227ce;

  /// No description provided for @timelineEvent1337ce.
  ///
  /// In en, this message translates to:
  /// **'The Hundred Years\' War begins as England and France struggle for dominance.'**
  String get timelineEvent1337ce;

  /// No description provided for @timelineEvent1347ce.
  ///
  /// In en, this message translates to:
  /// **'The first of many concurrences of the Black Death plague, believed to have wiped out as many as 50% of Europe\'s population by its end'**
  String get timelineEvent1347ce;

  /// No description provided for @timelineEvent1428ce.
  ///
  /// In en, this message translates to:
  /// **'Birth of the Aztec Empire in Mexico'**
  String get timelineEvent1428ce;

  /// No description provided for @timelineEvent1439ce.
  ///
  /// In en, this message translates to:
  /// **'Johannes Gutenberg invents the printing press'**
  String get timelineEvent1439ce;

  /// No description provided for @timelineEvent1492ce.
  ///
  /// In en, this message translates to:
  /// **'Christopher Columbus reaches the New World'**
  String get timelineEvent1492ce;

  /// No description provided for @timelineEvent1760ce.
  ///
  /// In en, this message translates to:
  /// **'The industrial revolution begins'**
  String get timelineEvent1760ce;

  /// No description provided for @timelineEvent1763ce.
  ///
  /// In en, this message translates to:
  /// **'Development of the Watt steam engine'**
  String get timelineEvent1763ce;

  /// No description provided for @timelineEvent1783ce.
  ///
  /// In en, this message translates to:
  /// **'End of the American War of Independence from the British Empire'**
  String get timelineEvent1783ce;

  /// No description provided for @timelineEvent1789ce.
  ///
  /// In en, this message translates to:
  /// **'The French Revolution begins'**
  String get timelineEvent1789ce;

  /// No description provided for @timelineEvent1914ce.
  ///
  /// In en, this message translates to:
  /// **'World War I'**
  String get timelineEvent1914ce;

  /// No description provided for @timelineEvent1929ce.
  ///
  /// In en, this message translates to:
  /// **'Black Tuesday signals the beginning of the Great Depression'**
  String get timelineEvent1929ce;

  /// No description provided for @timelineEvent1939ce.
  ///
  /// In en, this message translates to:
  /// **'World War II'**
  String get timelineEvent1939ce;

  /// No description provided for @timelineEvent1957ce.
  ///
  /// In en, this message translates to:
  /// **'launch of Sputnik 1 by the Soviet Union'**
  String get timelineEvent1957ce;

  /// No description provided for @timelineEvent1969ce.
  ///
  /// In en, this message translates to:
  /// **'Apollo 11 mission lands on the moon'**
  String get timelineEvent1969ce;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyStatement.
  ///
  /// In en, this message translates to:
  /// **'As explained in our {privacyUrl} we do not collect any personal information.'**
  String privacyStatement(Object privacyUrl);

  /// No description provided for @pageNotFoundBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back to civilization'**
  String get pageNotFoundBackButton;

  /// No description provided for @pageNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get pageNotFoundMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
