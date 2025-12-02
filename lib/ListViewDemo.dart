import 'package:flutter/material.dart';
import 'newPage.dart'; // Detailed page for travel destination

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({super.key});

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  // ------------------------------------------------------------
  // ORIGINAL COMMENT:
  // List of travel destinations
  // ------------------------------------------------------------
  // UPDATED:
  // Images are now local assets inside: assets/images/
  // Make sure pubspec.yaml contains:
  //
  // assets:
  //   - assets/images/
  //
  // And the folder contains 1.jpeg, 2.jpeg, 3.jpeg, 4.jpeg
  // ------------------------------------------------------------
  final List<Map<String, String>> places = [
    {"name": "France", "price": "1200", "img": "assets/images/1.jpeg"},
    {"name": "Japan", "price": "1500", "img": "assets/images/2.jpeg"},
    {"name": "Lebanon", "price": "8000", "img": "assets/images/3.jpeg"},
    {"name": "Turkey", "price": "1000", "img": "assets/images/4.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Original comment preserved
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Travel Destinations',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        // --------------------------------------------------------
        // NEW ICON FEATURES (open-book friendly)
        // Four icons added: search, favorite, settings, info
        // Each has a SnackBar to show user feedback
        // --------------------------------------------------------
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 26),
            onPressed: () {
              // TODO: implement search feature
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search feature clicked")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 26),
            onPressed: () {
              // TODO: implement favorite feature
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Favorite feature clicked")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white, size: 26),
            onPressed: () {
              // TODO: implement settings feature
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings feature clicked")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white, size: 26),
            onPressed: () {
              // TODO: implement info feature
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Info feature clicked")),
              );
            },
          ),
        ],
      ),
      body: Container(
        // ORIGINAL COMMENT: gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5D54A4), Color(0xFF9A57BD), Color(0xFFF28EC4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            itemCount: places.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              return _buildPlaceTile(context, places[index]);
            },
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // ORIGINAL COMMENT:
  // Build each travel card
  // ------------------------------------------------------------
  // UPDATED COMMENT FOR OPEN BOOK EXAM:
  // This function creates each ListTile card.
  // It receives a "place" Map with name, price, img.
  // On tap, it navigates to NewPage passing the place details.
  // ------------------------------------------------------------
  Widget _buildPlaceTile(BuildContext context, Map<String, String> place) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            place["img"]!,
            width: 58,
            height: 58,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          place["name"]!,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "Price: \$${place["price"]}",
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.white70,
        ),
        onTap: () {
          // Navigate to NewPage with details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewPage(
                title: place["name"]!,
                price: place["price"]!,
                image: place["img"]!,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ------------------------------------------------------------
// POTENTIAL EXAM QUESTIONS (and how to answer from code):
// ------------------------------------------------------------
// Q1: How do you switch from network images to local images in Flutter?
//     -> Check the 'places' list: "img": "assets/images/1.jpeg" (Image.asset used).
//
// Q2: How do you navigate from a list item to a detail page?
//     -> Check _buildPlaceTile(): Navigator.push(context, MaterialPageRoute(...))
//
// Q3: How is the gradient background implemented?
//     -> Check Scaffold -> Container -> BoxDecoration -> LinearGradient.
//
// Q4: How do you control spacing between list items?
//     -> Check ListView.separated -> separatorBuilder.
//
// Q5: How do you add a shadow and border to a container?
//     -> Check Container decoration with BoxShadow and Border.
//
// Q6: How can you add icon features in the AppBar?
//     -> Use IconButton widgets inside AppBar.actions and provide onPressed callbacks.
//
// Q7: How do you provide feedback when an icon is tapped?
//     -> Use ScaffoldMessenger.of(context).showSnackBar() for temporary messages.
//
// Q8: How do you style icons with different colors?
//     -> Set color property in Icon widget; can dynamically change based on state.
//
// Q9: How to add 4 different icons without affecting list tiles or gradient?
//     -> Simply add IconButton widgets in AppBar.actions; the gradient and list remain unchanged.
//
// Q10: How can you expand the functionality of each icon?
//      -> Implement search, favorites, settings, info screens or popups in onPressed().
