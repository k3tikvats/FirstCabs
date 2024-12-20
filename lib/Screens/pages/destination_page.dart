import 'package:firstcabs/Screens/pages/map_page.dart';
import 'package:flutter/material.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final TextEditingController _endPointController = TextEditingController();
  final List<String> destinations = [
    "Indira Gandhi International Airport",
    "Rohini Sector 18,19",
    "HUDA City Centre Metro Station"
  ];
  final List<RecentSearch> _recentSearches = [
    RecentSearch(
      title: "Indira Gandhi International Airport",
      subtitle: "Terminal 2B Rd, Indira Gandhi International...",
    ),
    RecentSearch(
      title: "Rohini Sector 18,19",
      subtitle: "Samaypur Badli daulatpur, Rohini Sector 18...",
    ),
    RecentSearch(
      title: "Huda City Centre Metro",
      subtitle: "Shalimar Huda City Center, Sector 29, New Delhi, Gurugram, Haryana 122007",
    ),
    RecentSearch(
      title: "Punjabi Bagh",
      subtitle: "Ring Rd, West Punjabi Bagh, Punjabi Bagh, New Delhi, Delhi, 110026",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Destination',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          // Location input card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Start point (DTU)
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            "HJB 316, Delhi technological University",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Vertical line
                    Padding(
                      padding: const EdgeInsets.only(left: 5.5),
                      child: Row(
                        children: [
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    // End point input
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _endPointController,
                            decoration: const InputDecoration(
                              hintText: "End point",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            // Add destination functionality
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Booking options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_alarm),
                    label: const Text("Pick-up now"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_outline),
                    label: const Text("Book for me"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recent Searches section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Recent searches list
          Expanded(
            child: ListView.builder(
              itemCount: _recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(_recentSearches[index].title),
                  subtitle: Text(
                    _recentSearches[index].subtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(startPoint:'Delhi Technological University',endPoint: _recentSearches[index].title),
                        ),
                      );
                  },
                );
              },
            ),
          ),
          // Bottom buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("Saved locations"),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("Set location on map"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _endPointController.dispose();
    super.dispose();
  }
}

// Model class for recent searches
class RecentSearch {
  final String title;
  final String subtitle;

  RecentSearch({
    required this.title,
    required this.subtitle,
  });
}
