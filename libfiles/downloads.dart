import 'package:flutter/material.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  _DownloadsScreenState createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<String> _downloads = [
    'User_Guide.pdf',
    'Invoice_0725.pdf',
    'Electrician_Manual.pdf',
    'Appointment_Slip.png',
  ];

  void _openDownload(String fileName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening "$fileName"...'),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteDownload(int index) {
    String removed = _downloads[index];
    setState(() {
      _downloads.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$removed removed'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      appBar: AppBar(
        title: Text('Downloads', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _downloads.isEmpty
          ? Center(
              child: Text("No downloads available.",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: _downloads.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                String file = _downloads[index];
                return ListTile(
                  leading: Icon(Icons.file_present_rounded, color: Colors.indigo),
                  title: Text(file),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.open_in_new, color: Colors.green),
                        onPressed: () => _openDownload(file),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _deleteDownload(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
