/*
 * Project      : dynamo
 * File         : get_address.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-25
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng(double lat, double lon) async {
  try {
    List<Placemark> mPlaceMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = mPlaceMark[0];
    return "${place.name} , ${place.subLocality} , ${place.locality}, ${place.administrativeArea},${place.country}, ${place.postalCode}";
  } catch (e) {
    return e.toString();
  }
}

Future<String> getCountryFromLatLng(double lat, double lon) async {
  try {
    List<Placemark> mPlaceMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = mPlaceMark[0];
    return "${place.country}";
  } catch (e) {
    return e.toString();
  }
}
