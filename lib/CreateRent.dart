import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/HomePage.dart';





class AddProductPage extends StatelessWidget {

final vehicleController = TextEditingController();
final categoryController = TextEditingController();
final transmissionController = TextEditingController();
final costController = TextEditingController();
final locationController = TextEditingController();
final operatingFromController = TextEditingController();
final operatingToController = TextEditingController();

Future addOrder(String category, String cost, String location, String ohFrom, String ohTo, String trans, String vname) async {
final SharedPreferences sp = await SharedPreferences.getInstance();
var username = sp.getString('username');
await FirebaseFirestore.instance.collection('vehicles').add({
'category :' : category,
'cost' : int.parse(cost),
'location' : location,
'operatinghoursfrom' : ohFrom,
'operatinghoursto' : ohTo,
'transmission' : trans,
'renter' : username,
'customer' : null,
'vehiclename' : vname,
'status' : "available"
});
}

@override
Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Add Product', style: TextStyle(color: Colors.white),),
  backgroundColor: Colors.blueAccent,
  ),
  body: Padding(
  padding: EdgeInsets.all(16.0),
  child: Column(
  children: <Widget>[
  TextField(
  controller : vehicleController,
  decoration: InputDecoration(
  labelText: 'Vehicle Name',
  border: OutlineInputBorder()
  ),
  ),
  SizedBox(height: 20),


          TextField(
            controller : categoryController,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),

          TextField(
            controller : transmissionController,
            decoration: InputDecoration(
              labelText: 'Transmission',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),

          TextField(
            controller : costController,
            decoration: InputDecoration(
              labelText: 'Cost',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),

          TextField(
            controller : locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),

          TextField(
            controller : operatingFromController,
            decoration: InputDecoration(
              labelText: 'Operating Hours From',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),

          TextField(
            controller : operatingToController,
            decoration: InputDecoration(
              labelText: 'Operating Hours To',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          
          
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              addOrder(categoryController.text, costController.text, locationController.text, operatingFromController.text, operatingToController.text, transmissionController.text, vehicleController.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('Submit',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Changed from primary to backgroundColor
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}

