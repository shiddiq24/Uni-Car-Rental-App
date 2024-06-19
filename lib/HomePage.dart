import 'package:flutter/material.dart';
import 'package:unicarrent/CreateRent.dart';
import 'package:unicarrent/OwnInvoiceList.dart';
import 'package:unicarrent/ProfileScreen.dart';
import 'package:unicarrent/ViewRent.dart';
import 'package:unicarrent/read%20data/GetAllVehicleStatus.dart';

import 'package:unicarrent/read%20data/GetAllVehicleCost.dart';
import 'package:unicarrent/read%20data/getAllVehicleName.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();
  String _searchTerm = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OwnInvoicelist()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProductPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  String sortCondition = "";

  void determineVehicleSnapshots(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  Stream<QuerySnapshot> sort() {
    Query vehiclesQuery = FirebaseFirestore.instance.collection('vehicles');

    if (sortCondition == "ascending") {
      vehiclesQuery = vehiclesQuery.orderBy("cost", descending: false);
    } else if (sortCondition == "descending") {
      vehiclesQuery = vehiclesQuery.orderBy('cost', descending: true);
    } else {
      vehiclesQuery = vehiclesQuery.orderBy('cost');
    }

    return vehiclesQuery.snapshots();
  }

  @override
  
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      title: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          controller: _searchController,
          onChanged: (value) {
            determineVehicleSnapshots(value);
          },
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.sort, color: Colors.white),
          onSelected: (String value) {
            setState(() {
              if (value == 'asc') {
                sortCondition = "ascending";
              } else {
                sortCondition = "descending";
              }
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'asc',
              child: ListTile(
                leading: Icon(Icons.arrow_upward),
                title: Text('Cost: Low to High'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'desc',
              child: ListTile(
                leading: Icon(Icons.arrow_downward),
                title: Text('Cost: High to Low'),
              ),
            ),
          ],
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: sort(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No available vehicles.'));
              } else {
                var docs = snapshot.data!.docs;
                if (_searchTerm.isNotEmpty) {
                  docs = docs.where((doc) {
                    var vehicleName = doc['vehiclename'] as String;
                    return vehicleName.toLowerCase().contains(_searchTerm.toLowerCase());
                  }).toList();
                }

                var docIDs = docs.map((doc) => doc.id).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                        ),
                        title: GetAllVehicleName(documentId: docIDs[index]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetAllVehicleCost(documentId: docIDs[index]),
                          ],
                        ),
                        trailing: GetAllVehicleStatus(documentId: docIDs[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RentCarPage(documentId: docIDs[index])),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Rent'),
        BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sell'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
  );
}

}
