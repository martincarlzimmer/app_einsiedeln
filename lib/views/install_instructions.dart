// lib/views/install_instructions.dart
import 'package:flutter/material.dart';

class InstallInstructions extends StatelessWidget {
  const InstallInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    // Base text style used for the normal instructions.
    const textStyle = TextStyle(fontSize: 14, color: Colors.black);
    // Header style for the main sections.
    const headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.indigo,
    );
    // Style for the language headers.
    const languageTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Color.fromRGBO(176, 148, 60, 1),
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Center(
        child: Text(
          "Installieranleitung / Install Instructions",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // iPhone / iOS Instructions
            const Text("iPhone / iOS:", style: headerTextStyle),
            const SizedBox(height: 5),
            const Text("Deutsch:", style: languageTextStyle),
            // German iPhone: inline image next to the word "Teilen-Schaltfläche"
            _buildInlineRichInstructionStep(
              leftText: "1. Tippe auf das Sharemenü ",
              imagePath: "assets/images/iphoneshare.png",
              rightText: " in der Menüleiste.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "2. Scrolle nach unten und tippe auf 'Zum Home-Bildschirm'.",
              textStyle: textStyle,
            ),
            const SizedBox(height: 10),
            const Text("English:", style: languageTextStyle),
            // English iPhone: inline image next to the word "Share"
            _buildInlineRichInstructionStep(
              leftText: "1. Tap the Share button ",
              imagePath: "assets/images/iphoneshare.png",
              rightText: " in the menu bar.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "2. Scroll down the list of options, then tap 'Add to Home Screen'.",
              textStyle: textStyle,
            ),
            const Divider(height: 20, thickness: 1),
            // Android Instructions
            const Text("Android:", style: headerTextStyle),
            const SizedBox(height: 5),
            const Text("Deutsch:", style: languageTextStyle),
            // German Android: inline image next to the word "Drei-Punkte-Symbol"
            _buildInlineRichInstructionStep(
              leftText: "1. Drücke das Drei-Punkte-Symbol ",
              imagePath: "assets/images/androidmenu.webp",
              rightText: " oben rechts, um das Menü zu öffnen.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "2. Wähle 'Zum Home-Bildschirm hinzufügen'.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "3. Drücke die 'Hinzufügen'-Taste im Popup.",
              textStyle: textStyle,
            ),
            const SizedBox(height: 10),
            const Text("English:", style: languageTextStyle),
            // English Android: inline image next to the word "three dot icon"
            _buildInlineRichInstructionStep(
              leftText: "1. Press the three dot icon ",
              imagePath: "assets/images/androidmenu.webp",
              rightText: " in the upper right to open the menu.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "2. Select 'Add to Home screen'.",
              textStyle: textStyle,
            ),
            _buildInstructionStep(
              "3. Press the 'Add' button in the popup.",
              textStyle: textStyle,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            child: const Text("Close", style: TextStyle(fontSize: 16)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  /// Builds a RichText widget for instruction steps that include an inline image.
  Widget _buildInlineRichInstructionStep({
    required String leftText,
    required String imagePath,
    required String rightText,
    required TextStyle textStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: leftText),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Image.asset(
                imagePath,
                width: 18,
                height: 18,
              ),
            ),
            TextSpan(text: rightText),
          ],
        ),
      ),
    );
  }

  /// Builds a simple text-based instruction step.
  Widget _buildInstructionStep(String step, {required TextStyle textStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        step,
        style: textStyle,
      ),
    );
  }
}
