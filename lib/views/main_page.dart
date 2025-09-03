// lib/views/main_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';
import 'package:app_einsiedeln/views/benediktiner.dart';
import 'package:app_einsiedeln/views/wahlfahrt.dart';
import 'package:app_einsiedeln/views/history.dart';
import 'alltag_im_kloster.dart';
import 'package:url_launcher/url_launcher.dart';
import 'install_instructions.dart'; // Import the popup widget

class MainPage extends StatefulWidget {
  final VoidCallback onNavigateToGuidedTour;

  const MainPage({super.key, required this.onNavigateToGuidedTour});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<String> _imagePaths = [
    'assets/images/kloster_front_horz.jpg',
    'assets/images/kloster_statue_vert.jpg',
    'assets/images/01_Gnadenkapelle-008.jpg',
    'assets/images/kloster_sunset.jpg',
    'assets/images/kloster_chandelier.jpg',
    'assets/images/kloster_facade.jpg',
    'assets/images/03_Decken_und_Boden-023.jpg',
    'assets/images/03_Decken_und_Boden-004.jpg',
    'assets/images/kloster_gate_fog.jpg',
    'assets/images/01_Gnadenkapelle-010.jpg',
    'assets/images/kloster_mountain_horz2.JPG',
    'assets/images/kloster_statue_fall.jpg',
    'assets/images/07_Orgeln-015.jpg',
    'assets/images/06_Unterer_Chor-0102.jpg',
    'assets/images/10_Oranges_Fenster-002.jpg'
  ];

  @override
  void initState() {
    super.initState();
    
    // Check for the query parameter "install" with value "yes"
    final installParam = Uri.base.queryParameters["install"];
    if (installParam?.toLowerCase() == "yes") {
      // Ensure that the context is available before showing the dialog.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const InstallInstructions();
          },
        );
      });
    }

    // Set up the timer for page view auto animation.
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea( // Wrap your entire page in SafeArea
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: size.height * 0.75,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _imagePaths[index],
                          fit: BoxFit.cover,
                          width: size.width,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withValues(alpha: 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    child: Column(
                      children: [
                        Text(
                          appLoc.welcome,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        ),
                        Text(
                          appLoc.klosterName,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 12.0,
                                color: Colors.black45,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: widget.onNavigateToGuidedTour,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(176, 148, 60, 1),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 6,
                          ),
                          child: Text(
                            appLoc.heroScreenTourButton,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Container with intro text now has a background image (kloster_silouette.png)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/kloster_silouette.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.6),
                      BlendMode.modulate,
                    ),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      appLoc.introTextwelcome,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    Text(
                      appLoc.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      appLoc.welcomeMonks,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    AboutUsButton(
                      label: appLoc.alltagImKloster,
                      imagePath: 'assets/images/kloster_grass_horz.jpg',
                      onPressed: () => _navigateTo(AllTagImKloster()),
                    ),
                    AboutUsButton(
                      label: appLoc.historyPage,
                      imagePath: 'assets/images/03_Decken_und_Boden-008.jpg',
                      onPressed: () => _navigateTo(KlosterHistoryPage()),
                    ),
                    AboutUsButton(
                      label: appLoc.wallfahrt,
                      imagePath: 'assets/images/01_Gnadenkapelle-010.jpg',
                      onPressed: () => _navigateTo(Wahlfahrt()),
                    ),
                    AboutUsButton(
                      label: appLoc.benediktiner,
                      imagePath: 'assets/images/kloster_hallway.jpg',
                      onPressed: () => _navigateTo(Benediktiner()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Bottom section with updated background image
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/kloster_front_horizon_sillouette.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.3),
                      BlendMode.modulate,
                    ),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      appLoc.genQuestions,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Kloster Einsiedeln\nCH-8840 Einsiedeln\nTel. +41 55 418 61 11\nkloster@kloster-einsiedeln.ch',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/Instagram.webp',
                              width: 30, height: 30),
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.instagram.com/kloster_einsiedeln');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          iconSize: 50,
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Image.asset('assets/images/Facebook.png',
                              width: 30, height: 30),
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.facebook.com/KlosterEinsiedeln');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          iconSize: 50,
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Image.asset('assets/images/youtube.png',
                              width: 35, height: 35),
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.youtube.com/KlosterEinsiedeln');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          iconSize: 50,
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Image.asset('assets/images/website_icon.png',
                              width: 30, height: 30),
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.kloster-einsiedeln.ch/');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          iconSize: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

class AboutUsButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const AboutUsButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 8.0,
                      color: Colors.black54,
                    )
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
