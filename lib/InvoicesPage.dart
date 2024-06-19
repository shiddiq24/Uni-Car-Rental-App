import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoicesPage extends StatefulWidget {
  final String documentId;

  InvoicesPage({required this.documentId});

  @override
  _InvoicesPageState createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  
  

  Future<String> getVehicleName(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('invoices').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['vehiclename'];
    }
    return 'invalid';
  }

  Future<String> getDate(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('invoices').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['date'];
    }
    return 'invalid';
  }

 

  Future<String> getCustomer(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('invoices').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['customer'];
    }
    return 'invalid';
  }

  Future<String> getRenter(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('invoices').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['renter'];
    }
    return 'invalid';
  }

  Future<String> getCost(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('invoices').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['cost'].toString();
    }
    return 'invalid';
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Details', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blueAccent, // Custom color for the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300], // Color for the car image placeholder
              child: Center(child: Text('Car Image Placeholder')),
            ),
            SizedBox(height: 30),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text('Brand', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getVehicleName(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Brand: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Brand: Error');
                } else {
                  return Text('${snapshot.data ?? 'Not found'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
                }
              },
            ),
            Text('Date', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getDate(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Date: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Date: Error');
                } else {
                  return Text('${snapshot.data ?? 'Not found'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), );
                }
              },
            ),
            Text('Customer', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getCustomer(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Customer: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Customer: Error');
                } else {
                  return Text('${snapshot.data ?? 'Not found'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
                }
              },
            ),
            Text('Renter', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getRenter(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Renter: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Renter: Error');
                } else {
                  return Text('${snapshot.data ?? 'Not found'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
                }
              },
            ),
            Text('Cost', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getCost(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Cost: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Cost: Error');
                } else {
                  return Text('Cost: ${snapshot.data ?? 'Not found'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
                }
              },
            ),
            
           
          ],
        ),
      ),
      
    );
  }
}
