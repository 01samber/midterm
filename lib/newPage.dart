import 'package:flutter/material.dart';
import 'ThankYouPage.dart'; // Make sure this file exists in lib folder

/*
---------------------------------------------------------
 NEWPAGE.DART — WHAT THIS FILE DOES
---------------------------------------------------------
✔ Opens when the user taps a destination in ListViewDemo
✔ Receives data: title, price, image
✔ Displays image, price, and allows booking 1–20 nights
✔ Includes function to calculate total cost = nights * price
✔ Added feature: Include Breakfast toggle with extra fee
---------------------------------------------------------
*/

class NewPage extends StatefulWidget {
  final String title;
  final String price;
  final String image;

  const NewPage({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  // --------------------------
  // STATE VARIABLES
  // --------------------------
  int _selectedNights = 1; // Default 1 night
  bool _breakfastIncluded = false; // Breakfast toggle
  double _totalPrice = 0; // Total price including optional features

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice(); // Initialize total price
  }

  // ---------------------------------------------------------
  // FUNCTION: calculate total cost
  // MULTIPLIES number of nights with price per night
  // ADDS $20 per night if breakfast is included
  // ---------------------------------------------------------
  void _calculateTotalPrice() {
    double basePrice = double.parse(widget.price); // price per night
    double breakfastFee =
        _breakfastIncluded ? 20.0 : 0; // breakfast fee per night
    setState(() {
      _totalPrice = _selectedNights * (basePrice + breakfastFee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A4BAF), Color(0xFFB86AD9), Color(0xFFF59CC3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --------------------------
              // DISPLAY IMAGE
              // --------------------------
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  widget.image,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // --------------------------
              // DISPLAY PRICE PER NIGHT
              // --------------------------
              Text(
                "Price: \$${widget.price} per night",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // --------------------------
              // STEPPER FOR NUMBER OF NIGHTS (1–20)
              // --------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Select nights: ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      if (_selectedNights > 1) {
                        setState(() {
                          _selectedNights--;
                          _calculateTotalPrice();
                        });
                      }
                    },
                  ),
                  Text(
                    '$_selectedNights',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      if (_selectedNights < 20) {
                        setState(() {
                          _selectedNights++;
                          _calculateTotalPrice();
                        });
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --------------------------
              // NEW FEATURE: Include Breakfast
              // --------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Include Breakfast (\$20/night): ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Checkbox(
                    value: _breakfastIncluded,
                    onChanged: (value) {
                      setState(() {
                        _breakfastIncluded = value!;
                        _calculateTotalPrice();
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --------------------------
              // DISPLAY TOTAL PRICE (Dynamic)
              // --------------------------
              Text(
                "Total Price: \$$_totalPrice",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------
              // BOOK BUTTON
              // --------------------------
              ElevatedButton(
                onPressed: () {
                  // Show confirmation Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Booking confirmed for $_selectedNights night(s)${_breakfastIncluded ? " with breakfast" : ""}. Total: \$$_totalPrice"),
                    ),
                  );

                  // Navigate to Thank You Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThankYouPage(
                        countryName: widget.title,
                      ),
                    ),
                  );
                },
                child: const Text("Book Now"),
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
Q1: How do you dynamically calculate total booking price?
A1: Use a function like _calculateTotalPrice() that multiplies price * nights + optional features.

Q2: How do you add a toggle feature (like breakfast)?
A2: Use a Checkbox or Switch widget and update state with setState().

Q3: How do you combine multiple features in price?
A3: Add fees per night for each selected feature, multiply by number of nights.

Q4: How to allow booking from 1–20 nights?
A4: Stepper using "-" and "+" buttons with min=1, max=20.

Q5: How to allow 1–infinity nights?
A5: Use a TextField, validate integer input >=1, and calculate total price accordingly.
---------------------------------------------------------
*/
