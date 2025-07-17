
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists || !userDoc.data().toString().contains('role')) {
        throw Exception("User role not found");
      }

      String role = userDoc['role'];
      _showSuccessDialog(role);
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      if (e.code == 'user-not-found') {
        message = 'No user found for this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else {
        message = e.message ?? message;
      }
      _showSnackBar(message, isError: true);
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessDialog(String role) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text("Login Successful!", style: TextStyle(color: Colors.green[800])),
          ],
        ),
        content: Text("Welcome back! You're logged in as $role."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (role == 'Admin') {
                Navigator.pushReplacementNamed(context, '/admin_home');
              } else if (role == 'Service Provider') {
                Navigator.pushReplacementNamed(context, '/provider_home');
              } else {
                Navigator.pushReplacementNamed(context, '/home_screen');
              }
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text('Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration('Email', Icons.email),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value.trim())) {
  return 'Enter a valid email';
}       
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: _buildInputDecoration('Password', Icons.lock),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter password' : null,
              ),
              SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: _loginUser,
                      child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.indigo)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: Text('Sign up', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
}
