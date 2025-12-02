import 'package:flutter/material.dart';
import 'login.dart'; // Entry point for login page

// ------------------------------------------------------------
// ORIGINAL COMMENT:
// Entry point of the app
// ------------------------------------------------------------
// UPDATED COMMENT FOR OPEN BOOK EXAM:
// The main() function is where the Flutter app starts.
// runApp() inflates the given widget and attaches it to the screen.
// ------------------------------------------------------------
void main() {
  runApp(const MyApp());
}

// ------------------------------------------------------------
// ORIGINAL COMMENT:
// Root widget
// ------------------------------------------------------------
// UPDATED COMMENT FOR OPEN BOOK EXAM:
// MyApp is a StatelessWidget because it does not need to maintain
// any mutable state. The MaterialApp widget defines the app-level
// configurations like theme, title, and home page.
// ------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Removes the debug banner in top-right corner
      title: "Travel App with Login", // App title
      theme: ThemeData(primarySwatch: Colors.cyan), // App theme color
      home: const Login(), // First page to show when the app runs
    );
  }
}

// ------------------------------------------------------------
// POTENTIAL EXAM QUESTIONS (and how to get the answer from code):
// ------------------------------------------------------------
// Q1: What is the purpose of main() in Flutter?
//     -> Look at the main() function: it calls runApp(MyApp())
//
// Q2: Why is MyApp a StatelessWidget?
//     -> Because the app-level configuration does not change dynamically
//
// Q3: How do you remove the debug banner in Flutter apps?
//     -> Check debugShowCheckedModeBanner: false
//
// Q4: Which page does the app display first?
//     -> The 'home' property in MaterialApp: const Login()
//
// Q5: How is the app theme set?
//     -> theme: ThemeData(primarySwatch: Colors.cyan)
