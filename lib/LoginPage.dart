import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/ForgetPass.dart';
import 'package:unicarrent/HomePage.dart';
import 'package:unicarrent/RegisterPage.dart';
import 'package:unicarrent/read%20data/getOneUser.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<String> getDocId() async {
    var docId = "";
    await FirebaseFirestore.instance
        .collection('users')
        .where('name :', isEqualTo: usernameController.text)
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            docId = snapshot.docs.first.id;
          }
        });
    return docId;
  }

  Future<String> validateUser(String docId, String password) async {
    if (docId.isEmpty) {
      return 'invalid';
    }
    var userRef = FirebaseFirestore.instance.collection('users').doc(docId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      if (password == data['password']) {
        return 'valid';
      }
    }
    return 'invalid';
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
  
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Image.asset('assets/Logoblack.png', width: 250, height: 200,),
              const Column(
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    makeInput(label: "Username", typeController: usernameController),
                    makeInput(label: "Password", typeController: passwordController, obscureText: true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      String docIDs = await getDocId();
                      if (docIDs.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Username does not exist')),
                        );
                        return;
                      }
                      var result = await validateUser(docIDs, passwordController.text);
                      if (result == 'valid') {
                        final SharedPreferences sp = await SharedPreferences.getInstance();
                        sp.setString('username', usernameController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Username or password incorrect')),
                        );
                      }
                    },
                    color: Colors.blueAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                      "Doesn't have an account? Register here",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      var data = {
                        "uname": usernameController.text,
                        "password": passwordController.text,
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPass()),
                      );
                    },
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({
    required String label,
    required TextEditingController typeController,
    bool obscureText = false,
  }) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: typeController,
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
