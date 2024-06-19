import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicarrent/Confirm.dart';



class ForgetPass extends StatelessWidget {
  //const ForgetPass({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> updateUser(String username, String password) async {
    print(username + " " + password);
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name :', isEqualTo: username)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('No user found with username: $username');
      return;
    }

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.update({
        'password': password,
      });
      print('Password updated for user: $username');
    }
  } catch (e) {
    print('Error updating user: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Column(
              children: <Widget>[
                Text("Forget Password", style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  makeInput(label: "Username", typeController: usernameController),
                  makeInput(label: "New Password", typeController: passwordController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40),
              child: Container(
                padding: const EdgeInsets.only(top:3, left:3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  
                ),
                child: MaterialButton(
                  minWidth : double.infinity,
                  height: 60,
                  onPressed : () {
                    updateUser(usernameController.text, passwordController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Confirm()));},
                  color : Colors.blueAccent,
                  elevation : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Text("Send To Email", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize : 18,
                    color: Colors.white,
                  ),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget makeInput({required String label, required TextEditingController typeController, bool obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400, // 'FontWeight' was missing 'Font' in your code
          color: Colors.black87,
        ),
      ),
      const SizedBox(height:5,),
      TextField(
        obscureText: obscureText,
        controller: typeController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      const SizedBox(height: 30,),
    ],
  );
}
}
