import 'package:flutter/material.dart';

class GoPremiumScreen extends StatelessWidget {
  const GoPremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4B5EAA), Color(0xFFEAF6FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Custom AppBar
              _buildAppBar(context),
              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Premium Icon with Animation
                    _buildPremiumIcon(),
                    SizedBox(height: 16),
                    // Title
                    _buildTitle(),
                    SizedBox(height: 8),
                    // Subtitle
                    _buildSubtitle(),
                    SizedBox(height: 20),
                    // Feature List
                    _buildFeatureList(),
                  ],
                ),
              ),
              // Upgrade Button
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildUpgradeButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Go Premium",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 48), // Balance the layout
        ],
      ),
    );
  }

  Widget _buildPremiumIcon() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Image.asset(
            'assets/images/premium.png',
            height: 100, // Reduced image size
            width: 100,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      "Unlock Elite Benefits",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A2B5F),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Enjoy priority access, exclusive offers, ad-free browsing, and 24/7 support.",
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[800],
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFeatureList() {
    final features = [
      {"icon": Icons.block, "text": "Ad-Free Experience"},
      {"icon": Icons.support_agent, "text": "24/7 Priority Support"},
      {"icon": Icons.verified, "text": "Premium Badges"},
      {"icon": Icons.local_offer, "text": "Exclusive Offers"},
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(feature["icon"] as IconData, color: Color(0xFF4B5EAA), size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature["text"] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A2B5F),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4B5EAA),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Upgrade process coming soon!"),
            backgroundColor: Color(0xFF4B5EAA),
          ),
        );
      },
      child: Text(
        "Upgrade Now",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}