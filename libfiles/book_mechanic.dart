import 'package:flutter/material.dart';

class BookMechanicScreen extends StatefulWidget {
  @override
  _BookMechanicScreenState createState() => _BookMechanicScreenState();
}

class _BookMechanicScreenState extends State<BookMechanicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedService;

  final List<String> _services = [
    'Engine Repair',
    'Oil Change',
    'Tire Replacement',
    'Battery Issue',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Mechanic', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Your Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Vehicle Location', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter location' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedService,
                decoration: InputDecoration(labelText: 'Service Required', border: OutlineInputBorder()),
                items: _services.map((service) {
                  return DropdownMenuItem(value: service, child: Text(service));
                }).toList(),
                onChanged: (value) => setState(() => _selectedService = value),
                validator: (value) => value == null ? 'Please select a service' : null,
              ),
              SizedBox(height: 24),
                 ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Booking submitted successfully!')),
                    );
                  }
                },
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Confirm Appointment', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
