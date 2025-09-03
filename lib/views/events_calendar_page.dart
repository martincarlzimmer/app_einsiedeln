//lib/views/events_calendar_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLoc.eventsCalendar,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: HtmlWidget(
                '''
                  <iframe 
                    src="https://www.kloster-einsiedeln.ch/gettimes_2024_08/" 
                    width="$screenWidth"
                    height="${screenHeight * 0.8}"
                    frameborder="0" 
                    allow="fullscreen"
                    style="border-radius: 10px; border: 1px solid #ccc;"
                  ></iframe>
                ''',
                key: UniqueKey(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
