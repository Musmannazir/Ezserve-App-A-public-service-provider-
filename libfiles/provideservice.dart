import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProvideServiceScreen extends StatefulWidget {
  @override
  _ProvideServiceScreenState createState() => _ProvideServiceScreenState();
}

class _ProvideServiceScreenState extends State<ProvideServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gmailController = TextEditingController();
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _timeSlotController = TextEditingController();
  final _feeController = TextEditingController();

  String? selectedService;
  String? existingDocId;
  Map<String, dynamic>? existingServiceData;

  final List<String> services = [
    'Doctor', 'Electrician', 'Plumber', 'Cleaner',
    'Sweeper', 'Carpenter', 'Mechanic', 'Beautician', 'Painter',
  ];

  @override
  void initState() {
    super.initState();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
    );
  }

  bool _isValidGmail(String gmail) {
    final emailRegExp = RegExp(r'^[\w-\.]+@gmail\.com$');
    return emailRegExp.hasMatch(gmail);
  }

  Future<void> _checkExistingService() async {
    final gmail = _gmailController.text.trim();
    if (!_isValidGmail(gmail)) return;

    try {
      final query = await FirebaseFirestore.instance
          .collection('services')
          .where('gmail', isEqualTo: gmail)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          existingDocId = query.docs.first.id;
          existingServiceData = query.docs.first.data();
        });
      } else {
        setState(() {
          existingDocId = null;
          existingServiceData = null;
        });
      }
    } catch (e) {
      print("Error checking existing service: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && selectedService != null && existingDocId == null) {
      final data = {
        'service': selectedService,
        'gmail': _gmailController.text.trim(),
        'name': _nameController.text.trim(),
        'specialization': _specializationController.text.trim(),
        'availability': _availabilityController.text.trim(),
        'timeSlot': _timeSlotController.text.trim(),
        'fee': _feeController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      };

      try {
        print("Submitting data: $data"); // Debug print

        await FirebaseFirestore.instance.collection('services').add(data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service submitted successfully!')),
        );

        _formKey.currentState!.reset();
        _gmailController.clear();
        setState(() {
          selectedService = null;
        });

        _checkExistingService();
      } catch (e) {
        print("Error submitting service: $e"); // <-- Debug output
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit service')),
        );
      }
    } else if (selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a service')),
      );
    }
  }

  Future<void> _deleteService() async {
    if (existingDocId != null) {
      try {
        await FirebaseFirestore.instance.collection('services').doc(existingDocId).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service deleted successfully!')),
        );
        setState(() {
          existingDocId = null;
          existingServiceData = null;
          _gmailController.clear();
        });
      } catch (e) {
        print("Error deleting service: $e");
      }
    }
  }

  Widget _buildCommonFields() {
    return Column(
      children: [
        SizedBox(height: 16),
        TextFormField(
          controller: _nameController,
          decoration: _inputDecoration('Full Name'),
          validator: (value) => value!.isEmpty ? 'Enter your name' : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _specializationController,
          decoration: _inputDecoration('Specialization / Skill'),
          validator: (value) => value!.isEmpty ? 'Enter specialization/skill' : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _availabilityController,
          decoration: _inputDecoration('Availability (e.g. Mon-Fri)'),
          validator: (value) => value!.isEmpty ? 'Enter availability' : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _timeSlotController,
          decoration: _inputDecoration('Time Slots (e.g. 10am-2pm)'),
          validator: (value) => value!.isEmpty ? 'Enter time slot' : null,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _feeController,
          decoration: _inputDecoration('Fee / Rate (PKR)'),
          keyboardType: TextInputType.number,
          validator: (value) => value!.isEmpty ? 'Enter fee or rate' : null,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _gmailController.dispose();
    _nameController.dispose();
    _specializationController.dispose();
    _availabilityController.dispose();
    _timeSlotController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        title: Text("Provide a Service"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _gmailController,
                decoration: _inputDecoration('Enter your Gmail'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your Gmail';
                  if (!_isValidGmail(value)) return 'Enter a valid Gmail';
                  return null;
                },
                onFieldSubmitted: (_) => _checkExistingService(),
                onChanged: (_) => _checkExistingService(),
              ),
              SizedBox(height: 16),
              if (existingServiceData != null) ...[
                Text(
                  "You have already submitted a service as a ${existingServiceData!['service']}.",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _deleteService,
                  icon: Icon(Icons.delete),
                  label: Text("Delete My Service"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ] else ...[
                DropdownButtonFormField<String>(
                  value: selectedService,
                  decoration: _inputDecoration('Select Service'),
                  items: services.map((service) => DropdownMenuItem(
                        value: service,
                        child: Text(service),
                      )).toList(),
                  onChanged: (value) => setState(() => selectedService = value),
                  validator: (value) =>
                      value == null ? 'Please select a service' : null,
                ),
                if (selectedService != null) _buildCommonFields(),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
