//lib/views/history.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class KlosterHistoryPage extends StatefulWidget {
  const KlosterHistoryPage({super.key});

  @override
  _KlosterHistoryPageState createState() => _KlosterHistoryPageState();
}

class _KlosterHistoryPageState extends State<KlosterHistoryPage> {
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);
  List<Map<String, dynamic>> historyEvents = [];
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
    final String csvString = await rootBundle.loadString('assets/kloster_history_texts.csv');
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

    setState(() {
      historyEvents = rowsAsListOfValues.sublist(1).map((List<dynamic> row) {
        return {
          'orderID': row[0],
          'dateGerman': row[1],
          'dateEnglish': row[2],
          'titleGerman': row[3],
          'titleEnglish': row[4],
          'textGerman': row[5],
          'textEnglish': row[6],
          'image': row[7],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLoc.historyPage,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: Stack(
        children: [
          _buildParallaxBackground(),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: historyEvents.length + 1, // +1 for intro section
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildIntroSection(); // First item is the intro text
              } else {
                return _buildTimelineItem(historyEvents[index - 1], index - 1, index == historyEvents.length);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/kloster_fog_forest.jpg',
        fit: BoxFit.cover,
        opacity: AlwaysStoppedAnimation(0.8),
      ),
    );
  }

  Widget _buildIntroSection() {
    final appLoc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appLoc.historyPage,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                appLoc.historyPageIntro,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event, int index, bool isLastItem) {
    final appLoc = AppLocalizations.of(context)!;
    bool isExpanded = _expandedIndex == index;
    String date = appLoc.localeName == 'de' ? event['dateGerman'] : event['dateEnglish'];
    String title = appLoc.localeName == 'de' ? event['titleGerman'] : event['titleEnglish'];
    String description = appLoc.localeName == 'de' ? event['textGerman'] : event['textEnglish'];
    bool hasImage = event['image'] != null && event['image'].isNotEmpty;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedIndex = _expandedIndex == index ? -1 : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isExpanded ? 20 : 16,
                  height: isExpanded ? 20 : 16,
                  decoration: BoxDecoration(
                    color: isExpanded ? Colors.white : primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                if (!isLastItem)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isExpanded ? 70 : 50,
                    width: 2,
                    color: primaryColor,
                    margin: EdgeInsets.only(top: 4),
                  ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Card(
                elevation: isExpanded ? 6 : 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (hasImage)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/${event['image']}',
                            width: double.infinity,
                            height: 170, // You can adjust or remove this if it conflicts with the desired layout
                            fit: BoxFit.contain,
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
