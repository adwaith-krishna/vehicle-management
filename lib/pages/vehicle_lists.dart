import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehiman/pages/home.dart';
import '../pages/vehicle_data.dart';
import '../pages/vehiview.dart';
import 'admin.dart';

class VehicleLists extends StatefulWidget {
  final String previousPage;

  VehicleLists({required this.previousPage});

  @override
  _VehicleListsState createState() => _VehicleListsState();
}

class _VehicleListsState extends State<VehicleLists> {
  List<VehicleData> _vehicleDataList = [];

  @override
  void initState() {
    super.initState();

    // Manually adding some sample data for now
    _vehicleDataList = [
      VehicleData(
        id: '1',
        vehicleMake: 'Toyota',
        vehicleModel: 'Corolla',
        vehicleNumber: 'XYZ 1234',
        fuelType: 'Petrol',
        imagePath: 'assets/car.png', // Correct image path
        status: 'Available',
      ),
      VehicleData(
        id: '2',
        vehicleMake: 'Honda',
        vehicleModel: 'Civic',
        vehicleNumber: 'ABC 5678',
        fuelType: 'Diesel',
        imagePath: 'assets/car.png', // Correct image path
        status: 'Taken',
      ),
      VehicleData(
        id: '3',
        vehicleMake: 'Honda',
        vehicleModel: 'City',
        vehicleNumber: 'XYZ 5678',
        fuelType: 'Diesel',
        imagePath: 'assets/car.png', // Correct image path
        status: 'Taken',
      ),
    ];
  }

  Future<bool> _handleBackButtonPress(BuildContext context) async {
    if (widget.previousPage == 'home') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (widget.previousPage == 'admin') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Admin()),
      );
    }
    return false; // Returning false allows the default back button behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBackButtonPress(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select a Vehicle'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 108, 189, 181),
                  Color.fromARGB(255, 200, 214, 191),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: _vehicleDataList.isEmpty
            ? Center(child: Text('No data available'))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of tiles in a row
                  childAspectRatio: 2 / 3, // Adjust the aspect ratio as needed
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: _vehicleDataList.length,
                itemBuilder: (context, index) {
                  VehicleData vehicleData = _vehicleDataList[index];
                  bool isTaken = vehicleData.status == 'Taken';
                  return GestureDetector(
                    onTap: () async {
                      final updatedVehicleData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehiViewPage(
                            previousPage: widget.previousPage,
                            vehicleData: vehicleData,
                            takeButtonDeactivated: isTaken,
                          ),
                        ),
                      );

                      if (updatedVehicleData != null) {
                        setState(() {
                          _vehicleDataList[index] = updatedVehicleData;
                        });
                      }
                    },
                    child: Container(
                      key: Key(vehicleData.id),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              vehicleData
                                  .imagePath, // Using the placeholder image
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${vehicleData.vehicleMake} ${vehicleData.vehicleModel}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  vehicleData
                                      .vehicleNumber, // Display vehicle number directly
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  vehicleData.status,
                                  style: TextStyle(
                                    color: isTaken ? Colors.red : Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
