import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'label': 'Ambulance', 'number': '1122'},
    {'label': 'Hospital Emergency', 'number': '042-1234567'},
    {'label': 'Blood Bank', 'number': '042-7654321'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: ListView(
        children: contacts.map((contact) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(Icons.local_phone, color: Colors.redAccent),
              title: Text(contact['label']!),
              subtitle: Text('Call: ${contact['number']}'),
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
