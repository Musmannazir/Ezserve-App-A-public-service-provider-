import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _symptomsController = TextEditingController();
  String? _selectedDoctor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> doctors = ['Dr. Ahsan', 'Dr. Sara', 'Dr. Imran'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameController, 'Full Name', Icons.person),
              SizedBox(height: 12),
              _buildTextField(_mobileController, 'Mobile Number', Icons.phone, keyboardType: TextInputType.phone),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Doctor',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medical_services),
                ),
                value: _selectedDoctor,
                items: doctors.map((doctor) {
                  return DropdownMenuItem(value: doctor, child: Text(doctor));
                }).toList(),
                onChanged: (value) => setState(() => _selectedDoctor = value),
                validator: (value) => value == null ? 'Please select a doctor' : null,
              ),
              SizedBox(height: 12),
              _buildTextField(_symptomsController, 'Purpose / Symptoms', Icons.description, maxLines: 2),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(_selectedDate == null
                    ? 'Select Appointment Date'
                    : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.edit),
                onTap: _pickDate,
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text(_selectedTime == null
                    ? 'Select Time'
                    : 'Time: ${_selectedTime!.format(context)}'),
                trailing: Icon(Icons.edit),
                onTap: _pickTime,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
        onPressed: _submitForm,
        icon: Icon(Icons.check, color: Colors.white),
        label: Text('Confirm Appointment', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
    );
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select date and time')),
        );
        return;
      }

      // Submit the form data to backend or Firebase here

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Appointment Confirmed'),
          content: Text('Your appointment has been booked successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back to main screen
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
