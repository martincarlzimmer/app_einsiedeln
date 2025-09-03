//lib/views/benediktiner.dart
import 'package:flutter/material.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class Benediktiner extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  final List<String> images = [
    'assets/images/25_kloster_history_present_future.webp',
    'assets/images/07_kloster_workshops.webp',
    'assets/images/kloster_engelweihe.jpg',
    'assets/images/kloster_profess.jpg',
    'assets/images/kloster_saint_sky.jpg'
  ];

  Benediktiner({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final textStyle = TextStyle(fontSize: 18.0, height: 1.5, color: Colors.black);
    final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: primaryColor);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.benediktiner, style: titleStyle),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Set the background to white
        child: ListView(
          children: <Widget>[
            textCard(appLoc.benediktinerIntro, textStyle),
            imageCard(images[0]),
            textCard(appLoc.benediktinerPar1, textStyle),
            imageCard(images[1]),
            textCard(appLoc.benediktinerPar2, textStyle),
            imageCard(images[2]),
            textCard(appLoc.benediktinerPar3, textStyle),
            imageCard(images[3]),
            textCard(appLoc.benediktinerPar4, textStyle),
            imageCard(images[4])
          ],
        ),
      ),
    );
  }

  Widget textCard(String text, TextStyle style) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Colors.white, // Ensure text cards are also white
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget imageCard(String imagePath) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white, // Card with white background
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
