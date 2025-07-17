import 'package:flutter/material.dart';

class BookElectricianScreen extends StatefulWidget {
  @override
  _BookElectricianScreenState createState() => _BookElectricianScreenState();
}

class _BookElectricianScreenState extends State<BookElectricianScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _issueType;
  DateTime? _selectedDate;

  final List<String> issues = [
    'Power outage',
    'Wiring problem',
    'Fan/Light repair',
    'Fuse issue',
    'Other'
  ];

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Electrician", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _issueType,
                decoration: InputDecoration(
                  labelText: 'Issue Type',
                  border: OutlineInputBorder(),
                ),
                items: issues.map((issue) {
                  return DropdownMenuItem(value: issue, child: Text(issue));
                }).toList(),
                onChanged: (value) => setState(() => _issueType = value),
                validator: (value) => value == null ? 'Select issue' : null,
              ),
              SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _selectedDate == null
                      ? "No date selected"
                      : "Selected: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
                trailing: ElevatedButton(
                  onPressed: () => _pickDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    minimumSize: Size(120, 40),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Pick Date"),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Electrician Booked")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please complete all fields")),
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