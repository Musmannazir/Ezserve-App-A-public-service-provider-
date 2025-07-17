import 'package:flutter/material.dart';

class PlumbingHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plumbing Help',style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigo
      ,iconTheme: IconThemeData(color: Colors.white), // Makes the arrow white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Emergency Contacts', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text('• 1122 - Rescue Services'),
            Text('• 0300-1234567 - 24/7 Plumber Line'),
            SizedBox(height: 20),
            Text('Tips', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text('• Shut off water valve in case of major leak.'),
            Text('• Do not attempt electrical plumbing if not trained.'),
          ],
        ),
      ),
    );
  }
}
