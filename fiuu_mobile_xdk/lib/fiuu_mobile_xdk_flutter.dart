import 'dart:async';

import 'package:flutter/services.dart';

class MobileXDK {
  static const MethodChannel _channel =
      const MethodChannel('fiuu_mobile_xdk_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> start(Map<String, dynamic> args) async {
    final String? result = await _channel.invokeMethod('startXDK', args);
    return result;
  }

  static Future<String?> googlePay(Map<String, dynamic> args) async {
    final String? result = await _channel.invokeMethod('startGooglePay', args);
    return result;
  }
}
