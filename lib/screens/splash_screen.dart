import 'package:flutter/material.dart';
import '../Authentication/login.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"), // Ensure login.png is in the assets folder
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(

            "\n\n\n\n\n\nWelcome to \nMy Simple Note App",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

  }
}
