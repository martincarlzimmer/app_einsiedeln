// lib/main.dart

/*
  Mini README:
  -----------
  This is the main entry point of our Flutter application. The app uses Provider for state management,
  enabling us to manage the app's locale (language) and tour type data centrally.
  
  Key Features:
  - Localization: Supports English and German via Flutter's localization system.
  - State Management: Utilizes ChangeNotifierProviders for language and tour type management.
  - App Shell: Uses AppShell as the main widget to encapsulate the overall app structure.
  
  How to Run:
  1. Ensure all dependencies are installed (run `flutter pub get`).
  2. Launch the app using `flutter run`.
  
  For additional configurations or updates, refer to the corresponding service and view files.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provides state management capabilities.
import 'package:flutter_localizations/flutter_localizations.dart'; // Supports localization.

import 'package:app_einsiedeln/I10n/app_localizations.dart';

import '/views/app_shell.dart'; // Main widget that builds the app shell.
import '/services/locale_provider.dart'; // Manages the current locale/language.
import '/services/tour_type_provider.dart'; // Manages the tour type state.

void main() {
  // Initialize the app with multiple providers for state management.
  runApp(
    MultiProvider(
      providers: [
        // Provider to manage application language.
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        // Provider to manage tour type data.
        ChangeNotifierProvider(create: (context) => TourTypeProvider()),
      ],
      child: const MyApp(), // Root widget of the application.
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the current locale from the LanguageProvider.
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      // Set the locale based on the provider's current value.
      locale: languageProvider.locale,

      // Register localization delegates for material and widget localization.
      localizationsDelegates: const [
        AppLocalizations.delegate, // Delegate for app-specific translations.
        GlobalMaterialLocalizations.delegate, // Provides material localization.
        GlobalWidgetsLocalizations.delegate, // Provides widget localization.
      ],

      // Define the locales that the app supports.
      supportedLocales: const [
        Locale('de'), // German.
        Locale('en'), // English.
      ],

      // Locale resolution callback to determine which locale to use.
      // If the device's locale isn't supported, the app falls back to the first supported locale.
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        // Check if the device's language is supported.
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        // If no match is found, use the first supported locale.
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      // Set the home widget of the app.
      home: AppShell(),
    );
  }
}
