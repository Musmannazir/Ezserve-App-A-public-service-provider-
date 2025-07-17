import 'package:flutter/material.dart';

class CarpenterScreen extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {
      'title': 'Book a Carpenter',
      'route': '/book_carpenter',
      'icon': Icons.handyman,
    },
    {
      'title': 'Available Carpenters',
      'route': '/available_carpenters',
      'icon': Icons.people,
    },
    {
      'title': 'Emergency',
      'route': '/emergency_carpenter',
      'icon': Icons.warning_amber_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carpenter Services', style: TextStyle(color: Colors.white)),
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
