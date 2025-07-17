import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedBirthYear;
  String? _selectedGender;
  final List<String> _years = List.generate(30, (i) => (2005 - i).toString());
  final List<String> _genders = ['Male', 'Female', 'Other'];

  bool _isSaving = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    final data = doc.data();
    if (data == null) return;

    setState(() {
      _firstNameController.text = data['firstName'] ?? '';
      _lastNameController.text = data['lastName'] ?? '';
      _usernameController.text = data['username'] ?? '';
      _emailController.text = data['email'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      _selectedBirthYear = data['birthYear'];
      _selectedGender = data['gender'];
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception("User not logged in");

      await _firestore.collection('users').doc(uid).update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'birthYear': _selectedBirthYear,
        'gender': _selectedGender,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile updated successfully!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update: ${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile picture
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit, size: 18, color: Colors.indigo),
                )
              ],
            ),
          ),
          SizedBox(height: 20),

          // Form
          Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField(label: "First Name", controller: _firstNameController),
                buildTextField(label: "Last Name", controller: _lastNameController),
                buildTextField(label: "Username", controller: _usernameController),
                buildTextField(label: "Email", controller: _emailController),
                buildTextField(label: "Phone Number", controller: _phoneController),
                SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _selectedBirthYear,
                  decoration: InputDecoration(
                    labelText: "Birth Year",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _years.map((year) {
                    return DropdownMenuItem(value: year, child: Text(year));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedBirthYear = value),
                ),
                SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _genders.map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
                SizedBox(height: 24),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(Icons.lock, color: Colors.white),
                  label: Text("Change Password", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/changepassword');
                  },
                ),
                SizedBox(height: 20),

                _isSaving
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _saveProfile,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text("Save Changes", style: TextStyle(color: Colors.white)),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
