import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userSignupScreen extends StatefulWidget {
  @override
  _UserSignupScreenState createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<userSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red),
        );
        return;
      }

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text.trim(),
          'email': email,
          'uid': userCredential.user!.uid,
          'role': 'User',
          'createdAt': Timestamp.now(),
        });

        if (mounted) _showSuccessDialog();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text("Signup Successful!", style: TextStyle(color: Colors.green[800])),
          ],
        ),
        content: Text("Welcome, ${_usernameController.text.trim()}!\nYour account has been created."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacementNamed(context, '/home_screen');
            },
            child: Text("Continue", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text('Sign Up',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
              ),
              SizedBox(height: 40),
              _buildTextField(_usernameController, 'Username', Icons.person, false),
              SizedBox(height: 20),
              _buildTextField(_emailController, 'Email', Icons.email, false, isEmail: true),
              SizedBox(height: 20),
              _buildTextField(_passwordController, 'Password', Icons.lock, true),
              SizedBox(height: 20),
              _buildTextField(_confirmPasswordController, 'Confirm Password', Icons.lock_outline, true),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: _signUp,
                child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.indigo)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text('Login', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool obscure,
      {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: _buildInputDecoration(label, icon),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'Enter $label';
        if (isEmail && !value.contains('@')) return 'Enter a valid email';
        if (label == 'Password' && value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.indigo),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      fillColor: Colors.white,
      filled: true,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
