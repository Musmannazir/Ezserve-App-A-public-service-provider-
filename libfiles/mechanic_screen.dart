import 'package:flutter/material.dart';

class MechanicScreen extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {
      'title': 'Book a Mechanic',
      'route': '/book_mechanic',
      'icon': Icons.build,
    },
    {
      'title': 'Available Mechanics',
      'route': '/available_mechanics',
      'icon': Icons.people,
    },
    {
      'title': 'Emergency',
      'route': '/emergency_mechanic',
      'icon': Icons.warning_amber_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Services', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final opt = options[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(opt['icon'], color: Colors.indigo),
              title: Text(opt['title']),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, opt['route']);
              },
            ),
          );
        },
      ),
    );
  }
}
