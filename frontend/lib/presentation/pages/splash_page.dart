import 'dart:async';
import 'package:dashboard/main.dart';
import 'package:dashboard/presentation/pages/home_page.dart';
import 'package:dashboard/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  _startSplashScreen() async {
    // Delay for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if JWT token is stored in SharedPreferences
    String? jwtToken = localDb.getString('jwt');

    // Navigate to appropriate screen based on the availability of JWT token
    if (jwtToken != null && jwtToken.isNotEmpty) {
      // Navigate to HomePage if JWT exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // Navigate to LoginPage if JWT does not exist
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash screen content (e.g., a logo)
            Icon(
              Icons.flash_on,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Property Manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}