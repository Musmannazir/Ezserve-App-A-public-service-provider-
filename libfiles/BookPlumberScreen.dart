import 'package:flutter/material.dart';

class BookPlumberScreen extends StatefulWidget {
  @override
  _BookPlumberScreenState createState() => _BookPlumberScreenState();
}

class _BookPlumberScreenState extends State<BookPlumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _selectedIssue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Plumber', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16), // Add spacing between fields
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
              ),
              SizedBox(height: 16), // Add spacing between fields
              DropdownButtonFormField<String>(
                value: _selectedIssue,
                decoration: InputDecoration(
                  labelText: 'Plumbing Issue',
                  border: OutlineInputBorder(),
                ),
                items: ['Leakage', 'Clogged Drain', 'Installation', 'Other']
                    .map((issue) => DropdownMenuItem(value: issue, child: Text(issue)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedIssue = value),
                validator: (value) => value == null ? 'Please select an issue' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Normally you'd send this data to backend
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Plumber booked successfully!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Confirm Appointment', style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}