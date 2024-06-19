import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicarrent/HomePage.dart';


class RentCarPage extends StatefulWidget {
  final String documentId;

  RentCarPage({required this.documentId});

  @override
  _RentCarPageState createState() => _RentCarPageState();
}

class _RentCarPageState extends State<RentCarPage> {
  final TextEditingController _dateController = TextEditingController();
  String? status;

  @override
  void initState() {
    super.initState();
    _fetchStatus();
  }

  Future<void> _fetchStatus() async {
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(widget.documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      setState(() {
        status = doc['status'];
      });
    }
  }

  Future addInvoice(String date, String documentId) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var username = sp.getString('username');
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    String renter = "";
    String location = "";
    String vehiclename = "";
    int cost = 0;
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      renter = data['renter'];
      location = data['location'];
      vehiclename = data['vehiclename'];
      cost = data['cost'];
    }

    await FirebaseFirestore.instance.collection('invoices').add({
      'customer': username,
      'renter': renter,
      'location': location,
      'vehiclename': vehiclename,
      'cost': cost,
      'date': date
    });

    await FirebaseFirestore.instance.collection('vehicles').doc(documentId).update({
      'status': "rented",
      'customer': username
    });
  }

  Future<void> selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

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

  String hto = "";

  Future<String> getHoursTo(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      hto = data['operatinghoursto'];
      print(hto);
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

  Future<String> getRenter(String documentId) async {
    if (documentId.isEmpty) {
      return 'data does not exist';
    }
    var userRef = FirebaseFirestore.instance.collection('vehicles').doc(documentId);
    var doc = await userRef.get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      return data['renter'];
    }
    return 'invalid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Car Details',
          style: TextStyle(color: Colors.white),
        ),
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
              height: 150,
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
                  return Text(
                    '${snapshot.data ?? 'Not found'}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            Text('Category', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getCategory(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Category: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Category: Error');
                } else {
                  return Text(
                    '${snapshot.data ?? 'Not found'}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            Text('Transmission', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getTrans(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Transmission: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Transmission: Error');
                } else {
                  return Text(
                    '${snapshot.data ?? 'Not found'}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            Text('Location', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getLocation(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Location : Loading...');
                } else if (snapshot.hasError) {
                  return Text('Location: Error');
                } else {
                  return Text(
                    '${snapshot.data ?? 'Not found'}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            Text('Operating Hours', style: TextStyle(color: Colors.grey)),
            FutureBuilder<String>(
              future: getHoursFrom(widget.documentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Operating Hours From: Loading...');
                } else if (snapshot.hasError) {
                  return Text('Operating Hours From: Error');
                } else {
                  return Text(
                    '${snapshot.data ?? 'Not found'} - ${hto}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
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
                  return Text(
                    'RM ${snapshot.data ?? 'Not found'}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 8),
                FutureBuilder<String>(
                  future: getRenter(widget.documentId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      return Text('${snapshot.data ?? 'Not found'}');
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            if (status != 'rented') 
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'DATE',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                readOnly: true,
                onTap: () {
                  selectDate();
                }
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (status != 'rented')
            ElevatedButton(
              onPressed: () {
                addInvoice(_dateController.text, widget.documentId);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                'Rent This Vehicle',  style: TextStyle(color: Colors.white),),
              style:
              ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Custom color for the 'Submit' button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
