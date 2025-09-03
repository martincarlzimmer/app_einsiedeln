//lib/views/tour_location_detail_views.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';
import 'package:app_einsiedeln/services/tour_type_provider.dart';
import 'package:app_einsiedeln/services/csv_loader.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:app_einsiedeln/widgets/interactive_blueprint.dart'; // Import new file

class TourLocationDetailView extends StatelessWidget {
  const TourLocationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final tourType = Provider.of<TourTypeProvider>(context).tourType;
    final isGerman = Localizations.localeOf(context).languageCode == 'de';

    return Scaffold(
      appBar: AppBar(
        title: Text(tourType == 'historical' ? appLoc.historicalTour : appLoc.spiritualTour),
      ),
      body: FutureBuilder<List<TourLocation>>(
        future: TourDataLoader().loadTourData(tourType, isGerman),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return InteractiveBlueprint(locations: snapshot.data!); // Still calls InteractiveBlueprint
          }
          return const Center(child: Text("No data available"));
        },
      ),
    );
  }
}
