//vehicle list page forwards to this page
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/vehicle_data.dart';

class VehiViewPage extends StatefulWidget {
  final VehicleData vehicleData;
  final String previousPage;
  final bool takeButtonDeactivated;

  const VehiViewPage({
    required this.vehicleData,
    required this.previousPage,
    required this.takeButtonDeactivated,
  });

  @override
  _VehiViewPageState createState() => _VehiViewPageState();
}

class _VehiViewPageState extends State<VehiViewPage> {
  String _status = 'available';
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Vehicle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image display with improved size and aspect ratio
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: FileImage(File(widget.vehicleData.imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Display vehicle number, make, model, and fuel type
            Text(
              widget.vehicleData.vehicleNumber,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.vehicleData.vehicleMake} ${widget.vehicleData.vehicleModel}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              widget.vehicleData.fuelType,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Display selected time if available
            if (_selectedTime != null)
              Text(
                "Time: ${_selectedTime!.format(context)}",
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            // Buttons for 'Take', 'Deliver', and 'Reserve' actions
            ElevatedButton(
              onPressed: widget.takeButtonDeactivated
                  ? null
                  : (_selectedTime == null ? _selectTime : null),
              child: Text('Take'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedTime != null
                  ? () async => _removeTimeFromPrefs()
                  : null,
              child: Text('Deliver'),
            ),
            SizedBox(height: 20),
            // Reserve button always grey but clickable
            ElevatedButton(
              onPressed: () {
                // Show the Snackbar message only when clicking Reserve
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('This feature will be available soon'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Always grey
              ),
              child: Text('Reserve'),
            ),
            SizedBox(height: 20),
            // Display status if vehicle is taken
            if (widget.takeButtonDeactivated)
              Text(
                'Status: Taken',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final currentTime = TimeOfDay.now();
    setState(() {
      _selectedTime = currentTime;
      widget.vehicleData.takenDateTime = DateTime.now();
      _status = 'taken';
    });
  }

  Future<void> _removeTimeFromPrefs() async {
    setState(() {
      _selectedTime = null;
    });
  }
}
