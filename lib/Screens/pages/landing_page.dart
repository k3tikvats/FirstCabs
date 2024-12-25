import 'package:firstcabs/Screens/pages/destination_page.dart';
import 'package:firstcabs/Screens/pages/map_page.dart';
import 'package:firstcabs/Screens/pages/vehicle_selectionpg.dart';
import 'package:firstcabs/widgets/features/destination_item.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  // Controller to manage the search bar input
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // Bottom navigation active index
  int _selectedIndex = 0;

  // Function to handle bottom navigation bar taps
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> destinations = [
    "Indira Gandhi International Airport",
    "Rohini Sector 18,19",
    "HUDA City Centre Metro Station"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        title: Row(
          children: [
            Image.asset(
              'lib/assets/icons/logo.png',
              height: 36,
              width: 168,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        onChanged: (value) {
                          print("Search Query: $value");
                        },
                        decoration: InputDecoration(
                          hintText: 'Current Location',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: locationController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.grey),
                                  onPressed: () {
                                    locationController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
        
            // Advertisement Section (Scrollable Ads)
            Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildAdCard('lib/assets/images/ad1.png'),
                  buildAdCard('lib/assets/images/ad2.png'),
                  buildAdCard('lib/assets/images/ad3.png'),
                ],
              ),
            ),
        
            const SizedBox(height: 10),
        
            // Suggestions Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suggestions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
        
            // Horizontal Tiles (Cab, Coming Soon)
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  // Use the SuggestionTile widget
                  SuggestionTile(
                    imagePath: 'lib/assets/icons/cab.png',
                    title: "Cab",
                  ),
                  SuggestionTile(
                    imagePath: '',
                    title: "Coming Soon",
                    isComingSoon: true,
                  ),
                  SuggestionTile(
                    imagePath: '',
                    title: "Coming Soon",
                    isComingSoon: true,
                  ),
                  SuggestionTile(
                    imagePath: '',
                    title: "Coming Soon",
                    isComingSoon: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
        
            // Search Destination Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Destination Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: destinationController,
                            decoration: const InputDecoration(
                              hintText: 'Search Destination',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            onChanged: (value) {
                              print("Search query: $value");
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DestinationPage()),
                              );
                            },
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Add functionality for "Later" button
                            print("Later button pressed");
                          },
                          icon: const Icon(Icons.watch_later, size: 18),
                          label: const Text("Later"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
        
                // Destination List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: destinations
                        .map((destination){
                        return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapPage(startPoint:'Delhi Technological University',endPoint: destination),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            DestinationItem(
                              title: destination,
                              icon: Icons.location_pin,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Account",
          ),
        ],
      ),
    );
  }

  // Widget for ad cards
  Widget buildAdCard(String assetPath) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // // Widget for suggestion tiles
  // Widget buildSuggestionTile(String imagePath, String title) {
  //   return Container(
  //     width: 100,
  //     margin: const EdgeInsets.only(left: 16),
  //     child: Column(
  //       children: [
  //         Image.asset(imagePath, height: 60, width: 60),
  //         const SizedBox(height: 5),
  //         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }

  // // Widget for Coming Soon tiles
  // Widget buildComingSoonTile(String title) {
  //   return Container(
  //     width: 100,
  //     margin: const EdgeInsets.only(left: 16),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade300,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Center(
  //       child: Text(
  //         title,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  // Widget for suggested destinations
  Widget buildDestinationItem(String title) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        print("Selected Destination: $title");
      },
    );
  }
}


