import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllVehicleStatus extends StatelessWidget {
  final String documentId;

  GetAllVehicleStatus({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference vehicles = FirebaseFirestore.instance.collection('vehicles');

    return FutureBuilder<DocumentSnapshot>(
      future: vehicles.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          Color backgroundColor = Colors.grey;
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['status'] == 'rented') {
            backgroundColor = Colors.red;
          } if (data['status'] == 'available') {
            backgroundColor = Colors.green;
          } 
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${data['status']}',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          );
          } else {
            return Text('Document does not exist');
          }
        }

        return Text('Loading...');
      },
    );
  }
}