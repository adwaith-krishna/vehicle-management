import 'package:flutter/material.dart';
import 'home.dart';
import 'admin.dart';
import 'profile.dart';

class Reserve extends StatefulWidget {
  final String previousPage;

  Reserve({required this.previousPage});

  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _handleBackButtonPress(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 30.0),
            onPressed: () {
              // Handle menu icon press
            },
          ),
          title: Center(
            child: Text(
              'RESERVE VEHICLES',
              style: TextStyle(color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black),
              iconSize: 40.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 108, 189, 181),
                  Color.fromARGB(255, 200, 214, 191)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Date: ${_selectedDate.toString().split(' ')[0]}'),
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time: ${_selectedTime.format(context)}'),
              ),
            ],
          ),
        ),
      ),
    );
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
    return false;
  }
}
