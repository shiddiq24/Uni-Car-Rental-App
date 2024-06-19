/*import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState() _HomePageState;
}

class _MyHomePageState extends State<HomePage> {
  final user = Firebaseauth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('signed in as: ' + user.email!),
            MaterialButton(
              onPressed: onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              color: Colors.black[200],
              child: Text('sign out'),
              )
          ],
        ),
      ),
    );
  }
}*/