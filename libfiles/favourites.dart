import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<String> _favourites = [
    'Dr. Ahmed - Cardiologist',
    'Electrician - Adeel Khan',
    'Plumber - Kamran Ali',
    'Cleaner - Sana Malik',
  ];

  void _removeFavourite(int index) {
    String removedItem = _favourites[index];
    setState(() {
      _favourites.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$removedItem removed from favourites'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        title: Text("Favourites", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: _favourites.isEmpty
          ? Center(
              child: Text("No favourites yet.", style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: _favourites.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.favorite, color: Colors.red),
                  title: Text(_favourites[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.indigo),
                    onPressed: () => _removeFavourite(index),
                  ),
                );
              },
            ),
    );
  }
}
