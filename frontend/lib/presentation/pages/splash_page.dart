import 'dart:async';
import 'dart:developer';
import 'package:dashboard/main.dart';
import 'package:dashboard/presentation/pages/admin_home_page.dart';
import 'package:dashboard/presentation/pages/user_home_page.dart';
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
    try {
      String? jwtToken = localDb.getString('jwtKey');
      String? userRole = localDb.getString('userRole');
      print(userRole);

      // Navigate to appropriate screen based on the availability of JWT token
      if (jwtToken != null && jwtToken.isNotEmpty) {
        // Navigate to HomePage based on the user role
        if (userRole == "User") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserHomePage(),
            ),
          );
        } else if (userRole == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AdminHomePage(), // Use AdminHomePage here
            ),
          );
        }
      } else {
        // Navigate to LoginPage if JWT does not exist
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } on Exception catch (e) {
      log(e.toString());
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
