import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = [
      {'title': 'Book an Appointment', 'route': '/book_appointment', 'icon': Icons.calendar_today},
      {'title': 'Check Available Doctors', 'route': '/available_doctors', 'icon': Icons.medical_services},
      {'title': 'Emergency', 'route': '/emergency', 'icon': Icons.warning_amber_rounded},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Services',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
            iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: options.map((option) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(option['icon'] as IconData, color: Colors.indigo),
                title: Text(
                  option['title'] as String,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pushNamed(context, option['route'] as String);
                },
              ),
            );
          }).toList(),
        ),
        
      ),
    );
  }
}
