import 'package:flutter/material.dart';
import 'login.dart';

// ------------------------------------------------------------
// SIGNUP.DART — WHAT THIS FILE DOES
// ------------------------------------------------------------
// ✔ Provides a signup page for new users
// ✔ Stores user credentials in an in-memory Map (users)
// ✔ Validates inputs (empty fields, existing account)
// ✔ Navigates to Login page after signup
//
// EXAM NOTES:
// -------------
// • Teaches user input handling with TextEditingController
// • Shows how to validate input and provide feedback
// • Demonstrates storing simple data in a Map
// • Explains navigation between screens
// • Shows use of SnackBar for messages
// ------------------------------------------------------------

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // ------------------------------------------------------------
  // ORIGINAL COMMENT:
  // Controllers to capture user input from text fields
  // ------------------------------------------------------------
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email input
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Password input
            TextField(
              controller: passwordController,
              obscureText: true, // hides password
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Sign up button
            ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // ------------------------------------------------------------
                // INPUT VALIDATION:
                // • Check empty fields
                // • Check if user already exists
                // ------------------------------------------------------------
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter email and password"),
                    ),
                  );
                  return;
                }

                if (users.containsKey(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account already exists. Login."),
                    ),
                  );
                  return;
                }

                // ------------------------------------------------------------
                // SAVE NEW USER
                // • Add the email-password pair to the Map
                // • In real apps, this would be a database or API
                // ------------------------------------------------------------
                users[email] = password;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Signup successful! Please login."),
                  ),
                );

                // Navigate to Login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              },
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 20),

            // Navigate to login if already have an account
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// POTENTIAL EXAM QUESTIONS:
// ------------------------------------------------------------
// Q1: How do you capture user input from a TextField?
//     → Use TextEditingController and access controller.text
//
// Q2: How do you hide text in password field?
//     → Set obscureText: true in TextField
//
// Q3: How do you validate user input?
//     → Use if statements to check empty fields or other conditions
//
// Q4: How do you store user data in Flutter for testing?
//     → Use a Map (in-memory storage) or other storage methods
//
// Q5: How to show a temporary message to the user?
//     → Use ScaffoldMessenger.of(context).showSnackBar(SnackBar(...))
//
// Q6: How to navigate to another screen after signup?
//     → Navigator.pushReplacement(MaterialPageRoute(builder: ...))
