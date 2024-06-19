import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllVehicleName extends StatelessWidget {
  final String documentId;

  GetAllVehicleName({required this.documentId});

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

          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          
            return Text('${data['vehiclename']}');
          } else {
            return Text('Document does not exist');
          }
        }

        return Text('Loading...');
      },
    );
  }
}
