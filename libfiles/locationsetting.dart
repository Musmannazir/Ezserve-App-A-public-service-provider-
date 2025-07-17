import 'package:flutter/material.dart';

class LocationSettingScreen extends StatefulWidget {
  @override
  _LocationSettingScreenState createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  bool _locationEnabled = true;
  String? _selectedCity;

  final List<String> _cities = [
    'Islamabad',
    'Lahore',
    'Karachi',
    'Peshawar',
    'Quetta',
    'Rawalpindi',
  ];

  void _toggleLocation(bool value) {
    setState(() {
      _locationEnabled = value;
      if (!value) _selectedCity = null;
    });
  }

  void _selectCity(String? city) {
    setState(() {
      _selectedCity = city;
    });

    if (_locationEnabled && city != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location set to $city"),
          backgroundColor: Colors.indigo,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        title: Text('Location Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              value: _locationEnabled,
              onChanged: _toggleLocation,
              title: Text('Enable Location Access'),
              activeColor: Colors.indigo,
            ),
            SizedBox(height: 20),
            if (_locationEnabled)
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(
                  labelText: 'Select City',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _cities
                    .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: _selectCity,
              ),
          ],
        ),
      ),
    );
  }
}
