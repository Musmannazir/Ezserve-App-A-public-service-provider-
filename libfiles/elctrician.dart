import 'package:flutter/material.dart';

class ElectricianScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = [
      {'title': 'Book an Electrician', 'route': '/bookelectrician', 'icon': Icons.electrical_services},
      {'title': 'Available Electricians', 'route': '/availableelectrician', 'icon': Icons.people_alt},
      {'title': 'Emergency Request', 'route': '/emergencyelectrician', 'icon': Icons.warning},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Electrician Services',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: options.map((option) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(option['icon'] as IconData, color: Colors.indigo),
              title: Text(
                option['title'] as String,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, option['route'] as String);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
