//lib/views/salve_newsletter_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class SalvePage extends StatelessWidget {
  const SalvePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!isLandscape) // **Only show text in portrait mode**
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  appLoc.newsLetterIntro,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            HtmlWidget(
              '''
              <iframe src="https://www.kloster-einsiedeln.ch/_blaetterpdf/salve_2025/salve_2025_02/files/assets/common/downloads/publication.pdf" 
              style="width:100%; height:800px; border:none;"></iframe>
              '''
            ),
          ],
        ),
      ),
    );
  }
}