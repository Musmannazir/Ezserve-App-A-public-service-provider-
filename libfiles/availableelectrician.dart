import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableElectriciansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Electricians", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('services')
            .where('service', isEqualTo: 'Electrician')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final electricians = snapshot.data?.docs;

          if (electricians == null || electricians.isEmpty) {
            return Center(child: Text('No electricians available at the moment.'));
          }

          return ListView.builder(
            itemCount: electricians.length,
            itemBuilder: (context, index) {
              final data = electricians[index].data() as Map<String, dynamic>;
              final name = data['name'] ?? 'No Name';
              final skill = data['specialization'] ?? 'No Specialty';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Icon(Icons.engineering, color: Colors.indigo),
                  title: Text(name),
                  subtitle: Text(skill),
                  trailing: Icon(Icons.call),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Calling $name...")),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
