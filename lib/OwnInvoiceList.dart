import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/HomePage.dart';
import 'package:unicarrent/InvoicesPage.dart';
import 'package:unicarrent/read%20data/GetAllInvoicesDate.dart';
import 'package:unicarrent/read%20data/getAllInvoicesVname.dart';


class OwnInvoicelist extends StatelessWidget {
  final List<String> docIDs = [];

  Future<void> getDocId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var username = sp.getString('username');
    await FirebaseFirestore.instance.collection('invoices').where('customer', isEqualTo: username).get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIDs.add(document.reference.id);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Invoices'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                    ),
                    title: GetAllInvoicesVname(documentId: docIDs[index]),
                    subtitle: GetAllInvoicesDate(documentId: docIDs[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoicesPage(documentId: docIDs[index])),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}