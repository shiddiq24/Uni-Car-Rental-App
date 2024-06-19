/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context. snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage()
          }
        },
      ),
    );
  }
}*/