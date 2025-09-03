//views/app_shell.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // **Added for SystemUiOverlayStyle**
import 'package:url_launcher/url_launcher.dart';
import '/views/main_page.dart';
import '/views/events_calendar_page.dart';
import '/views/live_stream_page.dart';
import '/views/guided_tour_home.dart';
import '/views/salve_newsletter_page.dart';
import '/widgets/custom_navigation_bar.dart';
import '/services/locale_provider.dart';


class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  final List<String> _titles = [
    " ",
    " ",
    "Live Stream",
    "Salve Newsletter",
    " ",
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      // Pass a callback to MainPage that sets the selected index to 4 (GuidedTourHome)
      MainPage(
        onNavigateToGuidedTour: () {
          setState(() {
            _selectedIndex = 4;
          });
        },
      ),
      EventsPage(),
      LiveStreamPage(),
      SalvePage(),
      GuidedTourHome(),
    ];
  }

  void _onItemTapped(int index) async {
    if (index == 5) {
      final Uri url = Uri.parse('https://shop.kloster-einsiedeln.ch/');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    bool isLiveStreamPage = _selectedIndex == 2;
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    

    return Scaffold(
      backgroundColor: Colors.white, // **Ensures entire background is white**
      appBar: (isLiveStreamPage && isLandscape)
          ? null
          : AppBar(
              toolbarHeight: 64, // **Skinnier app bar**
              backgroundColor: Colors.white, // **Forces the app bar to stay white**
              elevation: 0, // **No shadow**
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark, // **Prevents tinting on scroll**
              title: Text(
                _titles[_selectedIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // **Smaller title for balance**
                  fontWeight: FontWeight.bold,
                ),
              ),
              // **Smaller Logo, Maintaining Aspect Ratio**
              leadingWidth: 150, // **Reduced width**
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // **Adds buffer**
                  child: Image.asset(
                    'assets/images/klosterlogohorizontal.png',
                    fit: BoxFit.contain, // **Maintains aspect ratio**
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Locale newLocale = Localizations.localeOf(context).languageCode == 'de'
                          ? Locale('en')
                          : Locale('de');
                      languageProvider.setLocale(newLocale);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text(
                        'DE | EN',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: (isLiveStreamPage && isLandscape)
          ? null
          : CustomNavigationBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
