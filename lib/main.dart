import 'package:flutter/material.dart';

// 1. THIS IS THE REQUIRED ENTRY POINT
void main() {
  // The runApp function takes the root widget of your application
  runApp(const MyApp());
}

// 2. This is the root widget (a basic container for your app)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Smart Tile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the home property to the updated screen
      home: const PlaceholderScreen(),
    );
  }
}

// 3. The screen updated to match your design
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a slightly darker cream color for the background
    const Color darkCreamColor =
        Color(0xFFF0E6D6); // A slightly deeper cream/old lace color

    // Using Scaffold to set the background color
    return Scaffold(
      backgroundColor:
          darkCreamColor, // Set the slightly darker cream background color
      body: Center(
        // Use Center to center the content horizontally and vertically
        child: Column(
          // Use Column to stack the RichText and the Button vertically
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the children horizontally
          mainAxisSize: MainAxisSize
              .min, // Make the column occupy only the space it needs
          children: <Widget>[
            // 1. The RichText (Phrase)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      20.0), // Add horizontal padding for text on smaller screens
              child: RichText(
                textAlign: TextAlign.center, // Center the text itself
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 50, // Large font size for the entire text
                    fontWeight: FontWeight.bold, // Make the entire text bold
                    color:
                        Colors.black, // Default color for all non-styled text
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Enter '), // "Enter " in black, bold
                    TextSpan(
                      text: '"Phrase"', // "Phrase" in double quotes
                      style: TextStyle(
                        color: Colors.green, // Word in green color
                        fontStyle: FontStyle.italic, // Word in italics
                      ),
                    ),
                    const TextSpan(
                        text: '  to search'), // " to search" in black, bold
                  ],
                ),
              ),
            ),

            // 2. Vertical Spacer/Padding
            const SizedBox(
                height: 30.0), // Add vertical spacing between text and button

            // 3. The Green "Scan Me" Button
            ElevatedButton(
              onPressed: () {
                // TODO: Add your button functionality here (e.g., call a scan function)
                print('Scan Me button pressed!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set the button background to red
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20), // Adjust button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                ),
              ),
              child: const Text(
                'Scan Me',
                style: TextStyle(
                  fontSize: 24, // Set the text size of the button
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for contrast on green
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
