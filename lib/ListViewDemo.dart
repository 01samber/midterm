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

  // ------------------------------------------------------------
  // NEW STATE VARIABLES FOR ICON FEATURES
  // ------------------------------------------------------------
  List<Map<String, String>> displayedPlaces = [];
  Set<String> favorites = {}; // Stores names of favorite countries
  bool isDarkMode = false; // For settings toggle

  @override
  void initState() {
    super.initState();
    displayedPlaces = List.from(places); // Initially show all places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Original comment preserved
      backgroundColor: isDarkMode ? Colors.black : null, // for dark mode
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
        // ICON FEATURES UPDATED FUNCTIONALITY
        // --------------------------------------------------------
        actions: [
          // SEARCH ICON
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 26),
            onPressed: () async {
              // Opens a search delegate to filter destinations
              final result = await showSearch<String>(
                context: context,
                delegate: DestinationSearch(places: places),
              );
              if (result != null && result.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You selected: $result")),
                );
              }
            },
          ),

          // FAVORITE ICON (toggles all displayed places at once)
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 26),
            onPressed: () {
              setState(() {
                for (var p in displayedPlaces) {
                  if (favorites.contains(p["name"])) {
                    favorites.remove(p["name"]);
                  } else {
                    favorites.add(p["name"]!);
                  }
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text("Favorites updated: ${favorites.join(', ')}")),
              );
            },
          ),

          // SETTINGS ICON (dark mode toggle)
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white, size: 26),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white.withOpacity(0.9),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Dark Mode"),
                          Switch(
                            value: isDarkMode,
                            onChanged: (val) {
                              setState(() {
                                isDarkMode = val;
                              });
                              Navigator.pop(
                                  context); // Close modal after toggle
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // INFO ICON
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white, size: 26),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Info feature clicked")),
              );
            },
          ),
        ],
      ),
      body: Container(
        // ORIGINAL COMMENT: gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
                    Colors.grey.shade900,
                    Colors.grey.shade800,
                    Colors.grey.shade700
                  ]
                : const [
                    Color(0xFF5D54A4),
                    Color(0xFF9A57BD),
                    Color(0xFFF28EC4)
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            itemCount: displayedPlaces.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              return _buildPlaceTile(context, displayedPlaces[index]);
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
  // Added favorite logic: a heart icon appears in front of each country
  // which is lighted off by default and becomes red when clicked.
  // ------------------------------------------------------------
  Widget _buildPlaceTile(BuildContext context, Map<String, String> place) {
    bool isFav = favorites.contains(place["name"]);
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
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isFav) {
                    favorites.remove(place["name"]);
                  } else {
                    favorites.add(place["name"]!);
                  }
                });
              },
              child: Icon(
                Icons.favorite,
                color: isFav ? Colors.redAccent : Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                place["img"]!,
                width: 58,
                height: 58,
                fit: BoxFit.cover,
              ),
            ),
          ],
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

// ----------------------------
// SEARCH DELEGATE FOR OPEN-BOOK EXAM
// ----------------------------
class DestinationSearch extends SearchDelegate<String> {
  final List<Map<String, String>> places;

  DestinationSearch({required this.places});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = places
        .where((p) => p["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
      children: results
          .map((p) => ListTile(
                title: Text(p["name"]!),
                onTap: () {
                  close(context, p["name"]!);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = places
        .where((p) => p["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
      children: suggestions
          .map((p) => ListTile(
                title: Text(p["name"]!),
                onTap: () {
                  query = p["name"]!;
                  showResults(context);
                },
              ))
          .toList(),
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
//
// Q11: How is the search feature implemented?
//      -> Use a SearchDelegate class and showSearch() to filter items dynamically.
//
// Q12: How is favorite functionality handled?
//      -> Each ListTile has its own heart icon. Clicking toggles inclusion in the favorites Set.
//
// Q13: How is the dark mode toggle implemented in settings?
//      -> Use a boolean isDarkMode and rebuild Scaffold and gradient colors on change.
//
// Q14: How to connect icon actions to ListTile UI changes?
//      -> For favorites, check if the place name is in favorites Set and adjust leading heart icon color accordingly.
