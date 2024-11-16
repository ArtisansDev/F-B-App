/*
 * Project      : my_coffee
 * File         : get_location.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-29
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../alert/app_alert.dart';

class GetLocation {
  late Function getLocation;

  Future<void> checkLocationPermission(Function param0) async {
    getLocation = param0;
    var isFlag = await _checkLocationPermission();
    if (isFlag) {
      // Check location permission status
      PermissionStatus status = await Permission.location.status;

      if (status.isDenied) {
        // Request permission
        status = await Permission.location.request();

        if (status.isDenied) {
          // If permission is still denied, show a message
          _showPermissionDialog();
          return;
        } else if (status.isPermanentlyDenied) {
          // If permission is permanently denied, show a dialog to open app settings
          _showOpenSettingsDialog();
          return;
        }
      }
      _getCurrentLocation();
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return true;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return true;
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      getLocation(position);
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      getLocation(position);
    } catch (e) {
      AppAlert.showSnackBar(Get.context!, e.toString());
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission"),
        content: const Text(
            "Location permissions are required to access your location. Please enable them."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission Denied"),
        content:
            const Text("Please enable location permissions in app settings."),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings(); // Open app settings
              Navigator.of(context).pop();
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
