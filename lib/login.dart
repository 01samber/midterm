import 'package:flutter/material.dart';
import 'signup.dart';
import 'ListViewDemo.dart'; // Navigate to travel page after login

// ------------------------------------------------------------
// ORIGINAL COMMENT:
// In-memory storage for simplicity (email -> password)
// ------------------------------------------------------------
// UPDATED COMMENT FOR OPEN BOOK EXAM:
// This Map stores user credentials temporarily in memory.
// Key: email, Value: password
// Note: In a real app, credentials would be stored securely in a database.
// ------------------------------------------------------------
Map<String, String> users = {};

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers for email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ------------------------------------------------------------
            // ORIGINAL COMMENT: Email input field
            // ------------------------------------------------------------
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // ------------------------------------------------------------
            // ORIGINAL COMMENT: Password input field
            // ------------------------------------------------------------
            TextField(
              controller: passwordController,
              obscureText: true, // hides the text for security
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            // ------------------------------------------------------------
            // ORIGINAL COMMENT: Login button
            // ------------------------------------------------------------
            ElevatedButton(
              onPressed: () {
                // Retrieve text and remove whitespace
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Check if inputs are empty
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter email and password"),
                    ),
                  );
                  return; // stop execution
                }

                // Check if account exists
                if (!users.containsKey(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account not found. Please sign up."),
                    ),
                  );
                  return;
                }

                // Check if password matches
                if (users[email] != password) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Incorrect password")),
                  );
                  return;
                }

                // Login successful -> Navigate to ListViewDemo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ListViewDemo()),
                );
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            // ------------------------------------------------------------
            // ORIGINAL COMMENT: Navigate to signup page
            // ------------------------------------------------------------
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Signup()),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// POTENTIAL EXAM QUESTIONS (and how to answer from code):
// ------------------------------------------------------------
// Q1: How do you validate empty inputs in Flutter?
//     -> Check onPressed() in ElevatedButton: email.isEmpty || password.isEmpty
//
// Q2: How do you verify if a user exists and password matches?
//     -> Check users Map: containsKey(email) and users[email] != password
//
// Q3: How is navigation performed after login?
//     -> Navigator.pushReplacement(context, MaterialPageRoute(...))
//
// Q4: How do you go from Login page to Signup page?
//     -> TextButton onPressed navigates to Signup() using Navigator.pushReplacement
//
// Q5: How are text inputs retrieved in Flutter?
//     -> Using TextEditingController.text.trim()
//
// Q6: How is password hidden in input field?
//     -> TextField property obscureText: true
