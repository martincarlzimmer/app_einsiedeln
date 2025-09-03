//lib/views/kloster_tour_outside.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_einsiedeln/I10n/app_localizations.dart';
import 'package:csv/csv.dart';

/// A simple data model for each tour location.
class TourLocation {
  final int id;
  final String title;
  final String textGerman;
  final String textEnglish;
  final String imageFile;
  final double x;
  final double y;

  TourLocation({
    required this.id,
    required this.title,
    required this.textGerman,
    required this.textEnglish,
    required this.imageFile,
    required this.x,
    required this.y,
  });

  /// Factory method to create a TourLocation from a CSV row.
  factory TourLocation.fromCsv(List<dynamic> row) {
    return TourLocation(
      id: int.parse(row[0].toString()),
      title: row[1].toString(),
      textGerman: row[2].toString(),
      textEnglish: row[3].toString(),
      imageFile: row[4].toString(),
      x: double.parse(row[5].toString()),
      y: double.parse(row[6].toString()),
    );
  }
}

class TourOutside extends StatefulWidget {
  const TourOutside({super.key});

  @override
  _TourOutsideState createState() => _TourOutsideState();
}

class _TourOutsideState extends State<TourOutside> {
  late PageController _pageController;
  int selectedIndex = 0;
  List<TourLocation> locations = [];
  bool isLoading = true;

  // Define the original dimensions of your map image (adjust as needed)
  final double originalMapWidth = 1000;
  final double originalMapHeight = 707;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    loadCsvData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Load and parse the CSV file from assets.
  Future<void> loadCsvData() async {
    try {
      final csvString = await rootBundle.loadString('assets/kloster_tour_outside_texts.csv');
      List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvString, eol: '\n');

      // Assuming the CSV has a header row, skip it:
      csvTable.removeAt(0);

      locations = csvTable.map((row) => TourLocation.fromCsv(row)).toList();
    } catch (e) {
      debugPrint("Error loading CSV: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  /// Scale the CSV x coordinate to the map container width.
  double scaleX(double x, double containerWidth) {
    return (x / originalMapWidth) * containerWidth;
  }

  /// Scale the CSV y coordinate to the map container height.
  double scaleY(double y, double containerHeight) {
    return (y / originalMapHeight) * containerHeight;
  }

  @override
  Widget build(BuildContext context) {
    // Access localization to decide which language to show.
    var appLoc = AppLocalizations.of(context)!;
    bool isGerman = appLoc.localeName == 'de';

    return SafeArea(
      child: Scaffold(
        // Modern AppBar with a gradient background (using white here as requested)
        appBar: AppBar(
          title: Text(appLoc.outsideTour),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 4,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // Top part: PageView with tour location cards
                    Expanded(
                      flex: 3,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: locations.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 6,
                              shadowColor: Colors.black45,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          'assets/images/${location.imageFile}',
                                          height: 160,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        location.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        isGerman ? location.textGerman : location.textEnglish,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Bottom part: Map with markers overlay
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: originalMapWidth / originalMapHeight,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              children: [
                                // Map image with rounded corners
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/kloster_uebersicht.jpg',
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                // Custom markers on the map
                                ...locations.map((location) {
                                  final index = locations.indexOf(location);
                                  final left = scaleX(location.x, constraints.maxWidth);
                                  final top = scaleY(location.y, constraints.maxHeight);
                                  final isSelected = index == selectedIndex;
                                  final double markerRadius = isSelected ? 18 : 14;
                                  return Positioned(
                                    left: left - markerRadius,
                                    top: top - markerRadius,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        _pageController.animateToPage(
                                          selectedIndex,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      // ** Only the circle with the ID now, no name label. **
                                      child: Container(
                                        width: markerRadius * 2,
                                        height: markerRadius * 2,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? Colors.red
                                              : const Color.fromRGBO(176, 148, 60, 1),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.3),
                                              blurRadius: 4,
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            location.id.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: markerRadius < 16 ? 10 : 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
