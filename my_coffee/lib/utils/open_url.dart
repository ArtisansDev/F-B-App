/*
 * Project      : dynamo
 * File         : open_url.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-26
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMaps(String lat, String lon) async {
  final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lon";
  await openLaunchUrl(Uri.parse(googleMapsUrl));
}

Future<void> openGoogleMapsAddress(String address) async {
  final Uri googleMapUrl =
  Uri.parse("https://www.google.com/maps/search/?api=1&query=$address");
  await openLaunchUrl(googleMapUrl);
}

Future<void> openLaunchUrlWp(String number) async {
  var androidUrl =
      "whatsapp://send?phone=$number";
  var iosUrl =
      "https://wa.me/$number";
  if (Platform.isIOS) {
    await openLaunchUrl(Uri.parse(iosUrl));
  } else {
    await openLaunchUrl(Uri.parse(androidUrl));
  }
}

Future<void> openLaunchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}