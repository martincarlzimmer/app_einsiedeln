//views/alltag_im_kloster.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class AllTagImKloster extends StatefulWidget {
  const AllTagImKloster({super.key});

  @override
  _AllTagImKlosterState createState() => _AllTagImKlosterState();
}

class _AllTagImKlosterState extends State<AllTagImKloster> {
  final Color primaryColor = Color(0xFFB0943C);
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<Map<String, dynamic>> dailySchedule = [];

  // Set these to the actual pixel dimensions of your panorama image.
  final double imageIntrinsicWidth = 3442;
  final double imageIntrinsicHeight = 800;

  @override
  void initState() {
    super.initState();
    loadSchedule().then((data) {
      setState(() {
        dailySchedule = data;
      });
    });
  }

  Future<List<Map<String, dynamic>>> loadSchedule() async {
    try {
      final csvData = await rootBundle.loadString('assets/kloster_alltag_texte.csv');
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);
      List<Map<String, dynamic>> loadedSchedule = [];

      for (var i = 1; i < rowsAsListOfValues.length; i++) {
        var row = rowsAsListOfValues[i];
        IconData icon = getIconFromOrder(row[0].toString());
        loadedSchedule.add({
          'order': row[0],
          'time': row[1],
          'titleGerman': row[2],
          'titleEnglish': row[3],
          'textGerman': row[4],
          'textEnglish': row[5],
          'icon': icon,
        });
      }
      return loadedSchedule;
    } catch (e) {
      print('Error loading the schedule CSV: $e');
      return [];
    }
  }

  IconData getIconFromOrder(String order) {
    switch (order) {
      case '1': return Icons.alarm;
      case '2': return Icons.wb_twilight;
      case '3': return Icons.wb_sunny;
      case '4': return Icons.work_rounded;
      case '5': return Icons.church;
      case '6': return Icons.restaurant;
      case '7': return Icons.church;
      case '8': return Icons.menu_book;
      case '9': return Icons.coffee;
      case '10': return Icons.bedtime;
      default: return Icons.help_outline;
    }
  }

  List<Map<String, dynamic>> get _timelineEvents =>
      dailySchedule.where((event) => event['time'].isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLoc.alltagImKloster,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Stack(
        children: [
          _buildParallaxBackground(),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: dailySchedule.length + 1, // +1 for the intro page
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildIntroPage();
                    } else {
                      return _buildEventCard(dailySchedule[index - 1]);
                    }
                  },
                ),
              ),
              if (_currentIndex != 0) _buildWhiteNavigationBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxBackground() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight * 1.2;

              // We'll scale the image so that its height matches screenHeight,
              // while preserving aspect ratio. That means the final width
              // might be quite large if the image is wide.
              final double aspectRatio = imageIntrinsicWidth / imageIntrinsicHeight;
              final double finalWidth = screenHeight * aspectRatio;
              final double extraWidth = finalWidth - screenWidth;

              // totalPages = 1 (intro) + # of events
              final int totalPages = dailySchedule.length + 1;
              final double currentPage = _pageController.hasClients
                  ? _pageController.page ?? 0
                  : 0;
              // Range 0.0 to 1.0 as we go from first page to last
              final double normalizedOffset = (totalPages > 1)
                  ? (currentPage / (totalPages - 1))
                  : 0.0;
              // Shift the background from 0 to -extraWidth
              final double offset = -extraWidth * normalizedOffset;

              return Stack(
                children: [
                  Positioned(
                    left: offset,
                    top: 0,
                    width: finalWidth,
                    height: screenHeight,
                    child: OverflowBox(
                      maxWidth: finalWidth,
                      minWidth: finalWidth,
                      minHeight: screenHeight,
                      maxHeight: screenHeight,
                      child: Image.asset(
                        'assets/images/DSC_0734-Pano.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildIntroPage() {
    final appLoc = AppLocalizations.of(context)!;
    return _buildWhiteCard(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appLoc.alltagImKloster,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          SizedBox(height: 15),
          Text(
            appLoc.alltagImKlosterIntro,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black87),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                appLoc.zumAlltag,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final appLoc = AppLocalizations.of(context)!;
    String title = appLoc.localeName == 'de' ? event['titleGerman'] : event['titleEnglish'];
    String description = appLoc.localeName == 'de' ? event['textGerman'] : event['textEnglish'];

    return _buildWhiteCard(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(event['icon'], size: 50, color: primaryColor),
          SizedBox(height: 8),
          Text(event['time'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
          SizedBox(height: 6),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildWhiteNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: primaryColor, width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _timelineEvents.asMap().entries.map((entry) {
          Map<String, dynamic> event = entry.value;
          int targetIndex = dailySchedule.indexWhere((e) => e['time'] == event['time']) + 1;
          bool isSelected = _currentIndex == targetIndex;

          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                targetIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              setState(() => _currentIndex = targetIndex);
            },
            child: Column(
              children: [
                Icon(event['icon'], size: 28, color: isSelected ? primaryColor : Colors.black54),
                SizedBox(height: 4),
                Text(event['time'], style: TextStyle(fontSize: 12, color: isSelected ? primaryColor : Colors.black54)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child, EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(padding: EdgeInsets.all(16), child: child),
      ),
    );
  }
}
