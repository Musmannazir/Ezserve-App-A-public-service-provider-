import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allServices = [
    {'title': 'Doctor', 'imagePath': 'assets/images/doctor.png'},
    {'title': 'Electrician', 'imagePath': 'assets/images/electrician.png'},
    {'title': 'Plumber', 'imagePath': 'assets/images/plumber.png'},
    {'title': 'Cleaner', 'imagePath': 'assets/images/cleaner.png'},
    {'title': 'Sweeper', 'imagePath': 'assets/images/sweeper.png'},
    {'title': 'Carpenter', 'imagePath': 'assets/images/carpenter.png'},
    {'title': 'Mechanic', 'imagePath': 'assets/images/mechanic.png'},
    {'title': 'Beautician', 'imagePath': 'assets/images/beautician.png'},
    {'title': 'Painter', 'imagePath': 'assets/images/painter.png'},
  ];

  List<Map<String, dynamic>> displayedServices = [];

  @override
  void initState() {
    super.initState();
    displayedServices = allServices;
    _searchController.addListener(_filterServices);
  }

  void _filterServices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      displayedServices = allServices
          .where((service) =>
              service['title'].toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToService(String title) {
    final routes = {
      'Doctor': '/doctor',
      'Electrician': '/electrician',
      'Plumber': '/plumber',
      'Cleaner': '/cleaner_screen',
      'Sweeper': '/sweeper_screen',
      'Carpenter': '/carpenter_screen',
      'Mechanic': '/mechanic_screen',
      'Beautician': '/beautician_screen',
      'Painter': '/painter_screen',
    };

    if (routes.containsKey(title)) {
      Navigator.pushNamed(context, routes[title]!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service for $title is not available yet')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Available Services', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Search bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search services...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // Top Services
          if (_searchController.text.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: allServices.take(3).map((service) {
                      return GestureDetector(
                        onTap: () => _navigateToService(service['title']),
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(service['imagePath'], width: 40, height: 40),
                              SizedBox(height: 6),
                              Text(
                                service['title'],
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.indigo),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),

          // Label: Available Services
          Text('Available Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Service Grid or "No results"
          if (displayedServices.isEmpty)
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('No results found.', style: TextStyle(fontSize: 16)),
            )),
          if (displayedServices.isNotEmpty)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
              children: displayedServices.map((service) {
                return GestureDetector(
                  onTap: () => _navigateToService(service['title']),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.indigo, width: 1.4),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(service['imagePath'], width: 50, height: 50),
                        const SizedBox(height: 8),
                        Text(
                          service['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/go_premium');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'Go Premium'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

