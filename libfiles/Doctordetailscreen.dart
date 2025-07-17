import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot doctor;

  DoctorDetailScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor['name'] ?? 'Doctor Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailRow('Name', doctor['name']),
                detailRow('Specialization', doctor['specialization']),
                detailRow('Availability', doctor['availability']),
                detailRow('Available Time', doctor['timeSlot']),
                detailRow('Appointment Fee', 'Rs. ${doctor['fee']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$label: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo)),
          Expanded(
            child: Text(value ?? 'Not available', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
