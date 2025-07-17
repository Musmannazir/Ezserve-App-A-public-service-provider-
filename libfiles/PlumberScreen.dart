import 'package:flutter/material.dart';

class PlumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = [
      {'title': 'Book a Plumber', 'route': '/book_plumber', 'icon': Icons.plumbing},
      {'title': 'Available Plumbers', 'route': '/available_plumbers', 'icon': Icons.people},
      {'title': 'Plumbing Help', 'route': '/plumbing_help', 'icon': Icons.help_outline},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Plumber Services', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(option['icon'] as IconData, color: Colors.indigo),
              title: Text(option['title'] as String),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, option['route'] as String),
            ),
          );
        },
      ),
    );
  }
}
