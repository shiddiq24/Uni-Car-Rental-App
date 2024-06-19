import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:unicarrent/LoginPage.dart';
import 'package:unicarrent/RegisterPage.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              // Logo
              Center(
                child: Image.asset('assets/unicars_logo.png', height: 120),  // Make sure to adjust the path as necessary
              ),
              SizedBox(height: 40),
              Text(
                'UNICARS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'easy and affordable car rentals in UTM with models of cars varying from years and places near you',
                style: TextStyle(
                  color: Colors.grey[600], // More subtle grey color
                  fontSize: 14, // Smaller font size for the subtitle
                  height: 1.5, // Line spacing for better readability
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2), // Custom background color (example: blue shade)
                  minimumSize: Size(double.infinity, 50), // Full-width button with fixed height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2), // Custom background color (example: blue shade)
                  minimumSize: Size(double.infinity, 50), // Full-width button with fixed height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}