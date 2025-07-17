import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'welcome.dart';
import 'login.dart';
import 'signup.dart';
import 'home_screen.dart';
import 'doctorscreen.dart';
import 'appointment.dart';
import 'available.dart';
import 'emrgency.dart';
import 'elctrician.dart';
import 'availableelectrician.dart';
import 'bookelectrician.dart';
import 'emergencyelectrician.dart';
import 'plumberScreen.dart';
import 'availablePlumbersScreen.dart';
import 'plumbingHelpScreen.dart';
import 'BookPlumberScreen.dart';
import 'cleaner_screen.dart';
import 'book_cleaner_screen.dart';
import 'available_cleaners.dart';
import 'emergency_cleaner.dart';
import 'sweeper_screen.dart';
import 'book_sweeper.dart';
import 'available_sweeper.dart';
import 'emergency_sweeper.dart';
import 'carpenter_screen.dart';
import 'book_carpenter.dart';
import 'available_carpenter.dart';
import 'emergency_carpenter.dart';
import 'mechanic_screen.dart';
import 'book_mechanic.dart';
import 'available_mechanic.dart';
import 'emergency_mechanic.dart';
import 'beautician_screen.dart';
import 'book_beautician.dart';
import 'available_beautician.dart';
import 'emergency_beautician.dart';
import 'painter_screen.dart';
import 'book_painter.dart';
import 'available_painter.dart';
import 'emergency_painter.dart';
import 'ProfileScreen.dart';
import 'EditProfileScreen.dart';
import 'GoPremiumScreen.dart';
import 'subscription.dart';
import 'locationsetting.dart';
import 'displaysetting.dart';
import 'language.dart';
import 'favourites.dart';
import 'downloads.dart';
import 'changepassword.dart';
import 'provideservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _loadFonts();
  runApp(MyApp());
}

Future<void> _loadFonts() async {
  await Future.wait([
    rootBundle.load('assets/fonts/Poppins-Regular.ttf'),
    rootBundle.load('assets/fonts/Poppins-Bold.ttf'),
    rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Provider App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEAF6FF),
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ).apply(fontFamily: 'Poppins', fontSizeFactor: 1.0),
        iconTheme: IconThemeData(size: 24, color: Colors.indigo),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: AuthGate(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => userSignupScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/doctor': (context) => DoctorScreen(),
        '/book_appointment': (context) => BookAppointmentScreen(),
        '/available_doctors': (context) => AvailableDoctorsScreen(),
        '/emergency': (context) => EmergencyScreen(),
        '/electrician': (context) => ElectricianScreen(),
        '/bookelectrician': (context) => BookElectricianScreen(),
        '/availableelectrician': (context) => AvailableElectriciansScreen(),
        '/emergencyelectrician': (context) => ElectricianEmergencyScreen(),
        '/plumber': (context) => PlumberScreen(),
        '/available_plumbers': (context) => AvailablePlumbersScreen(),
        '/plumbing_help': (context) => PlumbingHelpScreen(),
        '/book_plumber': (context) => BookPlumberScreen(),
        '/cleaner_screen': (context) => CleanerScreen(),
        '/Book_cleaner_screen': (context) => BookCleanerScreen(),
        '/available_cleaners': (context) => AvailableCleanersScreen(),
        '/emergency_cleaner': (context) => EmergencyCleanerScreen(),
        '/sweeper_screen': (context) => SweeperScreen(),
        '/book_sweeper': (context) => BookSweeperScreen(),
        '/available_sweepers': (context) => AvailableSweepersScreen(),
        '/emergency_sweeper': (context) => EmergencySweeperScreen(),
        '/carpenter_screen': (context) => CarpenterScreen(),
        '/book_carpenter': (context) => BookCarpenterScreen(),
        '/available_carpenters': (context) => AvailableCarpentersScreen(),
        '/emergency_carpenter': (context) => EmergencyCarpenterScreen(),
        '/mechanic_screen': (context) => MechanicScreen(),
        '/book_mechanic': (context) => BookMechanicScreen(),
        '/available_mechanics': (context) => AvailableMechanicsScreen(),
        '/emergency_mechanic': (context) => EmergencyMechanicScreen(),
        '/beautician_screen': (context) => BeauticianScreen(),
        '/book_beautician': (context) => BookBeauticianScreen(),
        '/available_beauticians': (context) => AvailableBeauticiansScreen(),
        '/emergency_beautician': (context) => EmergencyBeauticianScreen(),
        '/painter_screen': (context) => PainterScreen(),
        '/book_painter': (context) => BookPainterScreen(),
        '/available_painters': (context) => AvailablePaintersScreen(),
        '/emergency_painter': (context) => EmergencyPainterScreen(),
        '/profile': (context) => ProfileScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
        '/go_premium': (context) => GoPremiumScreen(),
        '/subscription': (context) => SubscriptionScreen(),
        '/locationsetting': (context) => LocationSettingScreen(),
        '/displaysetting': (context) => DisplaySettingScreen(),
        '/language': (context) => LanguageScreen(),
        '/favourites': (context) => FavouritesScreen(),
        '/downloads': (context) => DownloadsScreen(),
        '/changepassword': (context) => ChangePasswordScreen(),
        '/provideservice': (context) => ProvideServiceScreen(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // User is logged in
        if (snapshot.hasData) {
          return HomeScreen();
        }

        // User not logged in
        return WelcomeScreen();
      },
    );
  }
}
