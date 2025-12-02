import 'package:flutter/material.dart';

/*
---------------------------------------------------------
 THANKYOUPAGE.DART — WHAT THIS FILE DOES
---------------------------------------------------------
✔ Opens after a successful booking from NewPage
✔ Receives the country name dynamically from previous page
✔ Displays:
   - Thank you message
   - A sentence: "[Country Name] is waiting for your awesome visit!"
   - Optional Back Home button to return to previous screen
✔ Fully commented for exam practice
---------------------------------------------------------
*/

class ThankYouPage extends StatelessWidget {
  // --------------------------
  // STATE VARIABLES
  // --------------------------
  final String countryName; // Country name received from previous page

  // --------------------------
  // CONSTRUCTOR
  // --------------------------
  const ThankYouPage({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --------------------------
      // FULLSCREEN CONTAINER WITH GRADIENT BACKGROUND
      // --------------------------
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A4BAF),
              Color(0xFFB86AD9),
              Color(0xFFF59CC3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --------------------------
              // ICON FOR VISUAL FEEDBACK
              // --------------------------
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.yellowAccent,
              ),
              const SizedBox(height: 20),

              // --------------------------
              // THANK YOU MESSAGE
              // --------------------------
              const Text(
                "Thank You for Using Our App!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // --------------------------
              // DYNAMIC COUNTRY MESSAGE
              // --------------------------
              Text(
                "$countryName is waiting for your awesome visit!",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.yellowAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // --------------------------
              // BACK HOME BUTTON
              // --------------------------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Returns to previous screen
                },
                child: const Text("Back Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
---------------------------------------------------------
EXAM QUESTIONS & ANSWERS:
---------------------------------------------------------
Q1: How do you pass data between screens in Flutter?
A1: Use constructor parameters when navigating with Navigator.push(), e.g.,
    Navigator.push(context, MaterialPageRoute(builder: (_) => ThankYouPage(countryName: "France")));

Q2: How do you create a fullscreen gradient background?
A2: Wrap the body in a Container with BoxDecoration → LinearGradient()

Q3: How do you display dynamic text based on a variable?
A3: Use string interpolation: "$variable is waiting for your visit!"

Q4: How do you navigate back to the previous screen?
A4: Use Navigator.pop(context);

Q5: Why use StatelessWidget here?
A5: ThankYouPage does not need to manage state; it only displays data passed to it.

Q6: How to make the page visually appealing for exams?
A6: Use Column, Center, SizedBox for spacing, Icon widget for feedback, and Text with TextStyle for styling.

Q7: How to style buttons with custom colors and padding?
A7: Use ElevatedButton.styleFrom() to set backgroundColor, foregroundColor, padding, and textStyle.
---------------------------------------------------------
*/
