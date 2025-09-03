//lib/views/guided_tour_home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';
import 'tour_location_detail_views.dart';
import 'kloster_tour_outside.dart';

class GuidedTourHome extends StatelessWidget {
  final Color accentColor = const Color.fromRGBO(176, 148, 60, 1);

  const GuidedTourHome({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white, // ✅ Ensures full white background
      body: Stack(
        children: [
          // **🌄 Background Gradient for a Modern Look**
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8F8F8), Color(0xFFECECEC)], // Subtle light gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // **📜 Main Content**
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // **📍 Title Section**
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      appLoc.tourHomeText,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                        letterSpacing: 0.5, // Slightly spaced letters for elegance
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // **🛤️ Spiritual Tour Button**
                  _buildTourButton(
                    context,
                    label: appLoc.spiritualTour,
                    imagePath: 'assets/images/05_Herz-Jesu-009.jpg',
                    onPressed: () {
                      Provider.of<TourTypeProvider>(context, listen: false)
                          .setTourType('spiritual');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourLocationDetailView()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // **🏛️ Historical Tour Button**
                  _buildTourButton(
                    context,
                    label: appLoc.historicalTour,
                    imagePath: 'assets/images/03_Decken_und_Boden-008.jpg',
                    onPressed: () {
                      Provider.of<TourTypeProvider>(context, listen: false)
                          .setTourType('historical');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourLocationDetailView()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // **🚶 Tour Outside Button**
                  _buildTourButton(
                    context,
                    label: appLoc.outsideTour,
                    imagePath: 'assets/images/kloster_front_horz3.jpg',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourOutside()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **🎨 Modernized Tour Button**
  Widget _buildTourButton(BuildContext context,
      {required String label,
      required String imagePath,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // **Wider button for better touch experience**
      height: 160, // **Better height for clear visibility**
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent, // No background, we use the image
          shadowColor: Colors.black45,
          elevation: 6, // **Softer elevation for a premium feel**
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // **🖼️ Background Image**
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),

            // **✨ Modern Glassmorphism Overlay**
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black.withValues(alpha: 0.15), // **Subtle overlay for readability**
                backgroundBlendMode: BlendMode.overlay,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1), // **Soft light effect**
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 20, // **Slightly bigger text for readability**
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0, // Elegant letter spacing
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 6.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
