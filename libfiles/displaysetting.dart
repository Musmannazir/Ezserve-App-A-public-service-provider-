import 'package:flutter/material.dart';

class DisplaySettingScreen extends StatefulWidget {
  @override
  _DisplaySettingScreenState createState() => _DisplaySettingScreenState();
}

class _DisplaySettingScreenState extends State<DisplaySettingScreen> {
  bool _darkMode = false;
  bool _largeText = false;
  String _accentColor = 'Indigo';

  final List<String> _colors = ['Indigo', 'Blue', 'Green', 'Orange', 'Red'];

  void _changeAccentColor(String? color) {
    if (color != null) {
      setState(() {
        _accentColor = color;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Accent color set to $color"),
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
        backgroundColor: Colors.indigo,
        title: Text("Display Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: _darkMode,
            title: Text("Dark Mode"),
            activeColor: Colors.indigo,
            onChanged: (val) {
              setState(() => _darkMode = val);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Dark mode ${val ? 'enabled' : 'disabled'}"),
                  backgroundColor: Colors.indigo,
                ),
              );
            },
          ),
          Divider(),
          SwitchListTile(
            value: _largeText,
            title: Text("Large Text"),
            activeColor: Colors.indigo,
            onChanged: (val) {
              setState(() => _largeText = val);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Large text ${val ? 'enabled' : 'disabled'}"),
                  backgroundColor: Colors.indigo,
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Accent Color"),
            trailing: DropdownButton<String>(
              value: _accentColor,
              items: _colors.map((color) {
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: _changeAccentColor,
            ),
          ),
        ],
      ),
    );
  }
}
