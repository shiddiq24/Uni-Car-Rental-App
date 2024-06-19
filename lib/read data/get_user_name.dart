import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  final String? passwordInput;

  GetUserName({required this.documentId, this.passwordInput});


  @override
  Widget build(BuildContext context) {

    //get the collection

    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = 
          snapshot.data!.data() as Map<String, dynamic>;
          if(passwordInput == data['password'])
          
            return Text('${data['name :']}');
          
          

      }
      return Text('loading..');
    }));
  }
}