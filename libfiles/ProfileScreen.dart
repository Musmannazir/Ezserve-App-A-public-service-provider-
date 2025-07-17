import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? username;
  String? email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          username = data['username'] ?? 'Unknown';
          email = data['email'] ?? 'Unknown';
          isLoading = false;
        });
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  Widget _buildProfileImage() {
    Widget imageWidget;

    if (_pickedImage != null) {
      if (kIsWeb) {
        imageWidget = Image.network(
          _pickedImage!.path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset('assets/images/profile.png'),
        );
      } else {
        imageWidget = Image.file(
          File(_pickedImage!.path),
          fit: BoxFit.cover,
        );
      }
    } else {
      imageWidget = Image.asset('assets/images/profile.png', fit: BoxFit.cover);
    }

    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[300],
        child: ClipOval(
          child: SizedBox(height: 100, width: 100, child: imageWidget),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await _auth.signOut();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature feature coming soon!')),
    );
  }

  void _showLanguageDialog() {
    final languages = ['English', 'Urdu', 'Arabic'];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            return ListTile(
              title: Text(lang),
              onTap: () => Navigator.pop(ctx),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('My Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showComingSoon("Settings"),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  children: [
                    _buildProfileImage(),
                    SizedBox(height: 10),
                    Text(
                      username ?? 'No Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email ?? 'No Email',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: Icon(Icons.edit, size: 16),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/edit_profile'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                buildProfileOption(icon: Icons.favorite_border, title: "Favourites", onTap: () {
                  Navigator.pushNamed(context, '/favourites');
                }),
                buildProfileOption(icon: Icons.download, title: "Downloads", onTap: () {
                  Navigator.pushNamed(context, '/downloads');
                }),
                buildProfileOption(icon: Icons.language, title: "Languages", onTap: _showLanguageDialog),
                buildProfileOption(icon: Icons.location_on, title: "Location", onTap: () {
                  Navigator.pushNamed(context, '/locationsetting');
                }),
                buildProfileOption(icon: Icons.subscriptions, title: "Subscription", onTap: () {
                  Navigator.pushNamed(context, '/subscription');
                }),
                buildProfileOption(icon: Icons.display_settings, title: "Display", onTap: () {
                  Navigator.pushNamed(context, '/displaysetting');
                }),
                Divider(),
                buildProfileOption(
                  icon: Icons.handshake,
                  title: "Provide a Service",
                  onTap: () => Navigator.pushNamed(context, '/provideservice'),
                ),
                buildProfileOption(icon: Icons.history, title: "Clear History", onTap: () {
                  _showComingSoon("Clear History");
                }),
                buildProfileOption(icon: Icons.logout, title: "Log Out", onTap: _logout),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Text('App Version 2.3', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildProfileOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () {},
    );
  }
}
