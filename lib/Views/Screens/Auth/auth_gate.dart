
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Views/Screens/Auth/login_screen.dart';
import 'package:task_manager_app/Views/Screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>( 
      future: _checkLoginState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); 
        } else {
          final isLoggedIn = snapshot.data ?? false; 
          return isLoggedIn ? const HomeScreen() :const  LoginScreen();
        }
      },
    );
  }

  Future<bool> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false; 
    return isLoggedIn;
  }
}
