//lib/widgets/custom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom; // Get bottom inset for iPhones

    return Container(
      height: 80 + bottomPadding, // **Increased height for better tap area**
      padding: EdgeInsets.only(bottom: bottomPadding), // Ensures it reaches the bottom on all devices
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // **Modern rounded look**
        color: Colors.white, // Matches the app's theme
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(176, 148, 60, 1),
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5), // **Moves icon slightly higher**
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.event),
            ),
            label: appLoc.eventsCalendar,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.live_tv),
            ),
            label: appLoc.liveStream,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.mail_outline),
            ),
            label: appLoc.newsLetter,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.map),
            ),
            label: appLoc.selfGuidedTour,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Icon(Icons.shopping_cart),
            ),
            label: appLoc.onlineShop,
          ),
        ],
      ),
    );
  }
}
