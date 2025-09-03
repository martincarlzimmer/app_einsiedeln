import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'I10n/app_localizations.dart';
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
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the'**
  String get welcome;

  /// No description provided for @klosterName.
  ///
  /// In en, this message translates to:
  /// **'Einsiedeln Monastery'**
  String get klosterName;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'We look forward to your visit and would already like to extend a warm welcome to you!'**
  String get welcomeMessage;

  /// No description provided for @welcomeMonks.
  ///
  /// In en, this message translates to:
  /// **'Abbot Urban Federer and the monks of Einsiedeln Abbey'**
  String get welcomeMonks;

  /// No description provided for @introTextwelcome.
  ///
  /// In en, this message translates to:
  /// **'We appreciate your interest in our monastic community and the pilgrimage site entrusted to our care. Einsiedeln Abbey is a historic Benedictine monastery, home to around forty monks, the most important pilgrimage site in Switzerland, and a place of culture, education, and encounter for over a thousand years.'**
  String get introTextwelcome;

  /// No description provided for @heroScreenTourButton.
  ///
  /// In en, this message translates to:
  /// **'Explore the Monastery'**
  String get heroScreenTourButton;

  /// No description provided for @genQuestions.
  ///
  /// In en, this message translates to:
  /// **'General Inquiries'**
  String get genQuestions;

  /// No description provided for @eventsCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calender'**
  String get eventsCalendar;

  /// No description provided for @liveStream.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get liveStream;

  /// No description provided for @newsLetter.
  ///
  /// In en, this message translates to:
  /// **'Salve'**
  String get newsLetter;

  /// No description provided for @newsLetterIntro.
  ///
  /// In en, this message translates to:
  /// **'Four times a year, our magazine Salve offers a glimpse into life behind the walls of the Einsiedeln and Fahr monasteries, along with the institutions associated with them. Our newsletter is only available in german.'**
  String get newsLetterIntro;

  /// No description provided for @selfGuidedTour.
  ///
  /// In en, this message translates to:
  /// **'Tour'**
  String get selfGuidedTour;

  /// No description provided for @onlineShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get onlineShop;

  /// No description provided for @kunstHistorischEinleitung.
  ///
  /// In en, this message translates to:
  /// **'Am Anfang der...'**
  String get kunstHistorischEinleitung;

  /// No description provided for @spirituelleEinleitung.
  ///
  /// In en, this message translates to:
  /// **'Seit jeher zi...'**
  String get spirituelleEinleitung;

  /// No description provided for @tourHomeText.
  ///
  /// In en, this message translates to:
  /// **'Self-Guided Tours:'**
  String get tourHomeText;

  /// No description provided for @spiritualTour.
  ///
  /// In en, this message translates to:
  /// **'Spiritual Tour'**
  String get spiritualTour;

  /// No description provided for @historicalTour.
  ///
  /// In en, this message translates to:
  /// **'Art History Tour'**
  String get historicalTour;

  /// No description provided for @outsideTour.
  ///
  /// In en, this message translates to:
  /// **'Grounds Tour'**
  String get outsideTour;

  /// No description provided for @miniMap.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get miniMap;

  /// No description provided for @donationText.
  ///
  /// In en, this message translates to:
  /// **'Would you like to support us in maintaining our church?'**
  String get donationText;

  /// No description provided for @donationButton.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donationButton;

  /// No description provided for @alltagImKloster.
  ///
  /// In en, this message translates to:
  /// **'A Day in the Monastery'**
  String get alltagImKloster;

  /// No description provided for @alltagImKlosterIntro.
  ///
  /// In en, this message translates to:
  /// **'People often ask us what a typical day in the life of a monk looks like, especially when they visit our monastery. The daily routine itself is easy to describe, but its deeper meaning can only be understood by living it. Over time, it becomes clear: it\'s about something far greater, an encounter with God.'**
  String get alltagImKlosterIntro;

  /// No description provided for @zumAlltag.
  ///
  /// In en, this message translates to:
  /// **'To the Schedule'**
  String get zumAlltag;

  /// No description provided for @historyPage.
  ///
  /// In en, this message translates to:
  /// **'Monastery History'**
  String get historyPage;

  /// No description provided for @historyPageIntro.
  ///
  /// In en, this message translates to:
  /// **'In its over thousand-year history, the monastery reflects the history of the Church and society. It shows that our monastery is not an island, but is connected in many ways to its environment. Flourishing and decline, idealism and decadence, holiness and sin, light and shadow alternate through the centuries. Yet, what began in the 9th century with Saint Meinrad has borne fruit in many ways and has become a blessing to countless people. Thus, our monastic community in the 21st century can build upon a solid foundation and feels privileged to continue writing the story of the monastery and pilgrimage site.'**
  String get historyPageIntro;

  /// No description provided for @wallfahrt.
  ///
  /// In en, this message translates to:
  /// **'Pilgrimage'**
  String get wallfahrt;

  /// No description provided for @wallfahrtIntro.
  ///
  /// In en, this message translates to:
  /// **'We monks of Einsiedeln Abbey are entrusted with the pilgrimage to Our Lady of Einsiedeln. The Benedictine Abbey and Marian pilgrimage form a unique combination in Einsiedeln. Together with our staff, we strive to create a place here where encounters are possible—with God, with people, and with oneself.'**
  String get wallfahrtIntro;

  /// No description provided for @wallfahrtHistory.
  ///
  /// In en, this message translates to:
  /// **'Einsiedeln is not a pilgrimage site based on a Marian apparition. Einsiedeln is a place of pilgrimage with a long tradition—a very long tradition with a strong monastic influence. In Einsiedeln, the monastery and the pilgrimage form a unique symbiosis, turning the sanctuary of the Mother of God in the heart of Switzerland into a Benedictine pilgrimage site. The history of pilgrimage in Einsiedeln begins with the simple cell of Saint Meinrad (+861), and over the centuries, it has made Einsiedeln the most important Marian pilgrimage site in Switzerland. The pilgrimage in the classical sense certainly dates back to the 12th century in Einsiedeln. Early written records from the early 14th century casually mention pilgrimages to Einsiedeln and also indicate that they were quite significant.'**
  String get wallfahrtHistory;

  /// No description provided for @benediktiner.
  ///
  /// In en, this message translates to:
  /// **'Benedictines'**
  String get benediktiner;

  /// No description provided for @benediktinerIntro.
  ///
  /// In en, this message translates to:
  /// **'We monks at Einsiedeln Abbey are Benedictines: We follow the monastic rule of Saint Benedict of Nursia. For Saint Benedict (480-547), the life of a monk is a search for God in the footsteps of Jesus, guided by the Gospel. The life of us Einsiedeln Benedictines unfolds in the rhythm of prayer, reading, work, and silence.'**
  String get benediktinerIntro;

  /// No description provided for @benediktinerPar1.
  ///
  /// In en, this message translates to:
  /// **'Benedict writes in his rule that nothing is to be preferred over the service of God. Therefore, the communal celebration of the Liturgy of the Hours and the Eucharist, along with scripture reading and personal prayer, form the core of our lives. In addition, we monks work in various areas of the monastery.'**
  String get benediktinerPar1;

  /// No description provided for @benediktinerPar2.
  ///
  /// In en, this message translates to:
  /// **'Since its founding in 934, the rule of Saint Benedict has shaped life at Einsiedeln Abbey. This is a long tradition that we gratefully maintain and translate into today.'**
  String get benediktinerPar2;

  /// No description provided for @benediktinerPar3.
  ///
  /// In en, this message translates to:
  /// **'The Rule of Benedict is, in a sense, the guiding principle of our monastery. The 73 chapters, written 1500 years ago, can no longer answer all the questions of a 21st-century monastery. Nevertheless, we can find answers to the questions and challenges of today in the spirit of Saint Benedict and his rule. Furthermore, the Rule of Benedict outlines an ideal of monastic life that is still relevant today.'**
  String get benediktinerPar3;

  /// No description provided for @benediktinerPar4.
  ///
  /// In en, this message translates to:
  /// **'Thus, we are convinced that it is still worthwhile to follow the path as a Benedictine monk at Einsiedeln Abbey today.'**
  String get benediktinerPar4;
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
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
