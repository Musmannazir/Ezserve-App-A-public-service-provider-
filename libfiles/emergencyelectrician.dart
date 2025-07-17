import 'package:flutter/material.dart';

class ElectricianEmergencyScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'label': '24/7 Helpline', 'number': '0300-1234567'},
    {'label': 'Local Grid Station', 'number': '0800-9000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electrician Emergency", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: ListView(
        children: contacts.map((contact) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(Icons.electrical_services, color: Colors.red),
              title: Text(contact['label']!),
              subtitle: Text("Call: ${contact['number']}"),
              trailing: Icon(Icons.call, color: Colors.green),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Dialing ${contact['number']}...")),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}