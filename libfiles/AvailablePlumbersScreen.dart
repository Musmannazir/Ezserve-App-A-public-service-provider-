import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailablePlumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Plumbers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('services')
            .where('service', isEqualTo: 'Plumber')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final plumbers = snapshot.data?.docs;

          if (plumbers == null || plumbers.isEmpty) {
            return Center(child: Text('No plumbers available at the moment.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: plumbers.length,
            itemBuilder: (context, index) {
              final data = plumbers[index].data() as Map<String, dynamic>;
              final name = data['name'] ?? 'No Name';
              final location = data['availability'] ?? 'No Location';

              return Card(
                child: ListTile(
                  leading: Icon(Icons.plumbing, color: Colors.indigo),
                  title: Text(name),
                  subtitle: Text('Location: $location'),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () {
                      // Add call or booking functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Booked $name!')),
                      );
                    },
                    child: Text('Book', style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
