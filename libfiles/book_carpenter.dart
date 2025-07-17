import 'package:flutter/material.dart';

class BookCarpenterScreen extends StatefulWidget {
  @override
  _BookCarpenterScreenState createState() => _BookCarpenterScreenState();
}

class _BookCarpenterScreenState extends State<BookCarpenterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedTask;

  final List<String> _tasks = [
    'Furniture Repair',
    'Door/Window Fix',
    'Cabinet Installation',
    'Custom Work',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Carpenter', style: TextStyle(color: Colors.white)),
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
                decoration: InputDecoration(labelText: 'Your Address', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTask,
                decoration: InputDecoration(labelText: 'Task Type', border: OutlineInputBorder()),
                items: _tasks.map((task) {
                  return DropdownMenuItem(value: task, child: Text(task));
                }).toList(),
                onChanged: (value) => setState(() => _selectedTask = value),
                validator: (value) => value == null ? 'Please select a task' : null,
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
