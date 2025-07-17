import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _plans = [
    {
      'title': 'Basic',
      'price': '\$4.99/month',
      'features': ['Ad-free', 'Limited Support', 'Standard Access']
    },
    {
      'title': 'Premium',
      'price': '\$9.99/month',
      'features': ['Priority Support', 'Unlimited Access', 'Exclusive Content']
    },
    {
      'title': 'Pro',
      'price': '\$19.99/month',
      'features': ['All Premium Features', 'Early Access', 'Personalized Service']
    },
  ];

  void _subscribe() {
    String selectedPlan = _plans[_selectedIndex]['title'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Subscribed to $selectedPlan plan successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // go back after subscription
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Subscription Plans', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._plans.asMap().entries.map((entry) {
                int index = entry.key;
                Map plan = entry.value;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? Colors.indigo.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedIndex == index ? Colors.indigo : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(plan['price'], style: TextStyle(fontSize: 16, color: Colors.indigo)),
                        SizedBox(height: 10),
                        ...plan['features'].map<Widget>((feature) => Row(
                              children: [
                                Icon(Icons.check, size: 18, color: Colors.indigo),
                                SizedBox(width: 8),
                                Text(feature),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _subscribe,
                  child: Text("Subscribe to ${_plans[_selectedIndex]['title']} ",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
