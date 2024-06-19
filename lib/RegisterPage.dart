import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/HomePage.dart';
import 'package:unicarrent/LoginPage.dart';




class RegisterPage extends StatelessWidget {
    //const RegisterPage({super.key});

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future addUserDetails(String name, String email, String password) async {
      await FirebaseFirestore.instance.collection('users').add({
        'name :' : name,
        'email' : email,
        'password' : password
      });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text('Register System'),
      ),
        body: SingleChildScrollView(
                child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                children: <Widget>[
        const Column(
                children: <Widget>[
        Text("Register", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
                ],
              ),
        Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
                children: <Widget>[
        makeInput(label: "name", typeController: nameController),
        makeInput(label: "email", typeController: emailController),
        makeInput(label: "Password", obscureText: true, typeController: passwordController),
                  ],
                ),
              ),
        Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
               
                  ),
        child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                    final SharedPreferences sp = await SharedPreferences.getInstance();
                    print(nameController.text);
                    sp.setString('username', nameController.text);
                  addUserDetails(nameController.text, emailController.text, passwordController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
                  ;},
                  
        color: Colors.blueAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
    
                    ),
        child: const Text(
                "Register",
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
                  onPressed: (){
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    "Have an account? Login here",
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

    Widget makeInput({required String label, required var typeController, bool obscureText = false}) {
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