import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package

class VehicleData {
  final String id; // Unique ID for the vehicle
  final String imagePath;
  final String vehicleNumber;
  final String vehicleMake;
  final String vehicleModel;
  final String fuelType;
  DateTime? takenDateTime; // Nullable DateTime field for taken date and time
  String status; // Status of the vehicle

  VehicleData({
    required this.id,
    required this.imagePath,
    required this.vehicleNumber,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.fuelType,
    this.takenDateTime, // Include takenDateTime in the constructor
    required this.status, // Include status in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'vehicleNumber': vehicleNumber,
      'vehicleMake': vehicleMake,
      'vehicleModel': vehicleModel,
      'fuelType': fuelType,
      'takenDateTime': takenDateTime?.toIso8601String(), // Convert DateTime to string if not null
      'status': status, // Include status in the map
    };
  }

  static VehicleData fromMap(Map<String, dynamic> map) {
    return VehicleData(
      id: map['id'],
      imagePath: map['imagePath'],
      vehicleNumber: map['vehicleNumber'],
      vehicleMake: map['vehicleMake'],
      vehicleModel: map['vehicleModel'],
      fuelType: map['fuelType'],
      takenDateTime: map['takenDateTime'] != null ? DateTime.parse(map['takenDateTime']) : null, // Parse string to DateTime if not null
      status: map['status'], // Assign status from map
    );
  }

  // Generate a unique ID using UUID
  static String generateUniqueId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
