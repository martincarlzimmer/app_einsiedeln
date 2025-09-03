// lib/widgets/location_details_popup.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';

void showLocationDetails(BuildContext context, TourLocation location) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final appLoc = AppLocalizations.of(context)!;
      final isGerman = Localizations.localeOf(context).languageCode == 'de';
      final initialHistorical =
          Provider.of<TourTypeProvider>(context, listen: false).tourType == 'historical';
      bool showHistorical = initialHistorical;

      final donationUrl = Uri.https(
        'donate.raisenow.io',
        '/khgfh',
        {
          'lng': isGerman ? 'de' : 'en',
          'supporter.message.value': location.name,
        },
      ).toString();

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          final description = showHistorical
              ? (isGerman
                  ? location.descriptionGermanHistorical
                  : location.descriptionEnglishHistorical)
              : (isGerman
                  ? location.descriptionGermanSpiritual
                  : location.descriptionEnglishSpiritual);

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            location.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: const Color.fromRGBO(176, 148, 60, 1),
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Main image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/${location.mainImageName}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Toggle Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(appLoc.spiritualTour),
                              Switch(
                                value: showHistorical,
                                activeThumbColor: const Color.fromRGBO(176, 148, 60, 1),
                                onChanged: (val) {
                                  setState(() {
                                    showHistorical = val;
                                  });
                                },
                              ),
                              Text(appLoc.historicalTour),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Description text
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.8,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // Donation prompt
                          Text(
                            appLoc.donationText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.8,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Donation button
                          ElevatedButton.icon(
                            onPressed: () => launchUrl(Uri.parse(donationUrl)),
                            icon: const Icon(Icons.favorite, color: Colors.white),
                            label: Text(
                              appLoc.donationButton,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(176, 148, 60, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Additional images carousel
                          if (location.otherImageNames.isNotEmpty)
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 240,
                                enableInfiniteScroll: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                aspectRatio: 16 / 9,
                              ),
                              items:
                                  location.otherImageNames.map((imageName) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.asset(
                                                      'assets/images/$imageName',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.asset(
                                            'assets/images/$imageName',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
