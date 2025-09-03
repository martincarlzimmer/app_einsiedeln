//lib/views/wahlfahrt.dart
import 'package:flutter/material.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class Wahlfahrt extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);

  final List<String> images = [
    'assets/images/01_Gnadenkapelle-010.jpg', // Add image paths as needed
  ];

  Wahlfahrt({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final textStyle = TextStyle(fontSize: 18.0, height: 1.5, color: Colors.black);
    final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: primaryColor);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.wallfahrt, style: titleStyle),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Set the background to white
        child: ListView(
          children: <Widget>[
            textCard(appLoc.wallfahrtIntro, textStyle),
            imageCard(images[0]),
            textCard(appLoc.wallfahrtHistory, textStyle),
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
