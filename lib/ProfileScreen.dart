import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:unicarrent/LoginPage.dart';
import 'package:unicarrent/OwnRentList.dart';
import 'package:unicarrent/read%20data/get_user_name.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  
  Future<String> getDocId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var username = sp.getString('username');
    var docId = "";
    await FirebaseFirestore.instance
        .collection('users')
        .where('name :', isEqualTo: username)
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            docId = snapshot.docs.first.id;
          }
        });
    return docId;
  }

  void logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("username");
  }

  Future<String> getUsername(String docId) async {
    if (docId.isEmpty) {
      return 'User does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('users').doc(docId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['name :'];
    }
    return 'invalid';
  }

  Future<String> getEmail(String docId) async {
    if (docId.isEmpty) {
      return 'User does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('users').doc(docId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['email'];
    }
    return 'invalid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text('Profile' ,style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: getDocId().then((docId) => getUsername(docId)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return itemProfile('Name', 'Loading...', CupertinoIcons.person);
                } else if (snapshot.hasError) {
                  return itemProfile('Name', 'Error', CupertinoIcons.person);
                } else {
                  return itemProfile('Name', snapshot.data ?? 'Not found', CupertinoIcons.person);
                }
              },
            ),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: getDocId().then((docId) => getEmail(docId)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return itemProfile('Email', 'Loading...', CupertinoIcons.mail);
                } else if (snapshot.hasError) {
                  return itemProfile('Email', 'Error', CupertinoIcons.mail);
                } else {
                  return itemProfile('Email', snapshot.data ?? 'Not found', CupertinoIcons.mail);
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (
                  
                ) {

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OwnRentlist()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('My Vehicles', style: TextStyle(color: Colors.white),),
              ),
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    "Logout",
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
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}