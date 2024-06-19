import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/HomePage.dart';
import 'package:unicarrent/OwnRentList.dart';


class EditVehicle extends StatelessWidget {

  final String documentId;

  EditVehicle({required this.documentId});

  final vehicleController = TextEditingController();
  final categoryController = TextEditingController();
  final transmissionController = TextEditingController();
  final costController = TextEditingController();
  final locationController = TextEditingController();
  final operatingFromController = TextEditingController();
  final operatingToController = TextEditingController();

  

    Future<String> getVehicleName(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['vehiclename'];
    }
    return 'invalid';
  }

  Future<String> getCategory(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['category :'];
    }
    return 'invalid';
  }

  Future<String> getTrans(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['transmission'];
    }
    return 'invalid';
  }

  Future<String> getLocation(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['location'];
    }
    return 'invalid';
  }

  Future<String> getHoursFrom(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['operatinghoursfrom'];
    }
    return 'invalid';
  }

  Future<String> getHoursTo(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['operatinghoursto'];
    }
    return 'invalid';
  }

  Future<String> getCost(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['cost'].toString();
    }
    return 'invalid';
  }
  
  Future updateOrder(String category, String cost, String location, String ohFrom, String ohTo, String trans, String vname) async {
      
      var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
      var doc = await userRef.get();
      var data = doc.data() as Map<String, dynamic>;

      if (category.isEmpty) {
        category = data['category :'];
      }
      if (cost.isEmpty) {
        cost = data['cost'].toString();
      }
      if (location.isEmpty) {
        location = data['location'];
      }
      if (ohFrom.isEmpty) {
        ohFrom = data['operatinghoursfrom'];
      }
      if (ohTo.isEmpty) {
        ohTo = data['operatinghoursto'];
      }
      if (trans.isEmpty) {
        trans = data['transmission'];
      }
      if (vname.isEmpty) {
        vname = data['vehiclename'];
      }

      await userRef.update({
        'category :': category,
        'cost': int.parse(cost),
        'location': location,
        'operatinghoursfrom': ohFrom,
        'operatinghoursto': ohTo,
        'transmission': trans,
        'vehiclename': vname,
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Vehicle Information'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<String>(
              future: getVehicleName(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: vehicleController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', 
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getCategory(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', 
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getTrans(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: transmissionController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', // Use snapshot.data for the label text
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getCost(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: costController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', // Use snapshot.data for the label text
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getLocation(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', // Use snapshot.data for the label text
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getHoursFrom(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: operatingFromController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', // Use snapshot.data for the label text
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            FutureBuilder<String>(
              future: getHoursTo(documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // You can show a loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TextField(
                    controller: operatingToController,
                    decoration: InputDecoration(
                      labelText: snapshot.data ?? 'Label', // Use snapshot.data for the label text
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
          
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateOrder(categoryController.text, costController.text, locationController.text, operatingFromController.text, operatingToController.text, transmissionController.text, vehicleController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => OwnRentlist()));
              },
              child: Text('Update', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed from primary to backgroundColor
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
