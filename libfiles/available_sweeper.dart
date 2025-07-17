import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableSweepersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Sweepers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('services')
            .where('service', isEqualTo: 'Sweeper')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final sweepers = snapshot.data?.docs;

          if (sweepers == null || sweepers.isEmpty) {
            return Center(child: Text('No sweepers available at the moment.'));
          }

          return ListView.builder(
            itemCount: sweepers.length,
            itemBuilder: (context, index) {
              final data = sweepers[index].data() as Map<String, dynamic>;
              final name = data['name'] ?? 'No Name';
              final area = data['availability'] ?? 'Unknown Area';
              final rating = data['rating'] ?? 'N/A';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Icon(Icons.cleaning_services, color: Colors.blue),
                  ),
                  title: Text(name),
                  subtitle: Text('Area: $area • Rating: $rating'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selected $name")),
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
