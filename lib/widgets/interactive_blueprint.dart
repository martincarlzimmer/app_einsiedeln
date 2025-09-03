//lib/widgets/interactive_blueprint.dart
import 'package:flutter/material.dart';
import 'package:app_einsiedeln/models/tour_location_csv.dart';
import 'package:app_einsiedeln/widgets/location_details_popup.dart';
import 'package:app_einsiedeln/I10n/app_localizations.dart';

class InteractiveBlueprint extends StatelessWidget {
  final List<TourLocation> locations;

  InteractiveBlueprint({super.key, required this.locations});

  final double originalImageWidth = 442.0;
  final double originalImageHeight = 734.0;
  final Color primaryColor = Color.fromRGBO(176, 148, 60, 1);
  final Color redColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            minScale: 0.5,
            maxScale: 2.5,
            child: AspectRatio(
              aspectRatio: originalImageWidth / originalImageHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double displayWidth = constraints.maxWidth;
                  double displayHeight = constraints.maxHeight;

                  return Stack(
                    children: [
                      Image.asset(
                        'assets/images/klosterfloorplanV3.png',
                        width: displayWidth,
                        height: displayHeight,
                        fit: BoxFit.contain,
                      ),
                      ...locations.map((location) {
                        double xPosition =
                            (location.x / originalImageWidth) * displayWidth;
                        double yPosition =
                            (location.y / originalImageHeight) * displayHeight;

                        return Stack(
                          children: [
                            Positioned(
                              left: xPosition - 15,
                              top: yPosition - 15,
                              child: GestureDetector(
                                onTap: () =>
                                    showLocationDetails(context, location),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: redColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(-1, -1),
                                      ),
                                      BoxShadow(
                                        color: Colors.white38,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    location.id.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Center the label under the marker.
                            Positioned(
                              left: xPosition,
                              top: yPosition + 20,
                              child: FractionalTranslation(
                                translation: Offset(-0.5, 0.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: 80),
                                    child: Text(
                                      location.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      // Visitor Entrance text at the bottom left of the floorplan
                      Positioned(
                        left: 30,
                        bottom: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Visitor\nEntrance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        // FAB with label "gesamt uebersicht" below it
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () => _showMiniMap(context),
                backgroundColor: redColor,
                shape: CircleBorder(),
                elevation: 8,
                splashColor: Colors.white,
                highlightElevation: 12,
                child: Icon(Icons.map, color: Colors.white, size: 30),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  appLoc.miniMap,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMiniMap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Define original image size
              double originalWidth = 1000;
              double originalHeight = 707;

              // Determine the scaled width and height while maintaining aspect ratio
              double maxDialogWidth = constraints.maxWidth * 0.9;
              double maxDialogHeight = constraints.maxHeight * 0.8;
              double aspectRatio = originalWidth / originalHeight;
              double scaledWidth = maxDialogWidth;
              double scaledHeight = maxDialogWidth / aspectRatio;

              if (scaledHeight > maxDialogHeight) {
                scaledHeight = maxDialogHeight;
                scaledWidth = scaledHeight * aspectRatio;
              }

              // Calculate scaled text position
              double scaleFactorX = scaledWidth / originalWidth;
              double scaleFactorY = scaledHeight / originalHeight;
              double textX = 100 * scaleFactorX;
              double textY = 352 * scaleFactorY;

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: scaledWidth,
                            height: scaledHeight,
                            child: Image.asset(
                              'assets/images/kloster_uebersicht.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Overlay text with white text inside a red box
                          Positioned(
                            left: textX,
                            top: textY,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Text(
                                "Visitor\nEntrance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: Colors.black, size: 24),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
