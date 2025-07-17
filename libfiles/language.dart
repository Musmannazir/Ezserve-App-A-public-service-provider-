import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<String> _languages = [
    'English',
    'Urdu',
    'Arabic',
    'French',
    'German',
    'Spanish',
    'Chinese',
  ];

  String _selectedLanguage = 'English';

  void _selectLanguage(String lang) {
    setState(() {
      _selectedLanguage = lang;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Language changed to $lang"),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      appBar: AppBar(
        title: Text('Languages', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: _languages.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          return ListTile(
            title: Text(lang),
            trailing: _selectedLanguage == lang
                ? Icon(Icons.check_circle, color: Colors.indigo)
                : null,
            onTap: () => _selectLanguage(lang),
          );
        },
      ),
    );
  }
}
