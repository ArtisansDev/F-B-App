import 'dart:convert';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/get_utils.dart';
import "dart:html" as html;

import '../constants/app_constants.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/order_place/order_place_guest_info_request.dart';
import '../lang/translation_service_key.dart';

///partha paul
///get_web_info
///26/12/24
getWebView() async {
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (kIsWeb) {
    final userAgent = html.window.navigator.userAgent;
    final browserName = getBrowserName(userAgent.toLowerCase());
    final platform = html.window.navigator.platform;
    final appName = html.window.navigator.appName;
    var appVersion = getChromeVersion(userAgent.toLowerCase());
    appVersion =
        appVersion.isEmpty ? html.window.navigator.appVersion : appVersion;
    final language = html.window.navigator.language;
    String sTitle = AppConstants.iAccessKey == 2
        ? sAppNameAppleCinemas.tr
        : (AppConstants.iAccessKey == 1 ? sAppNameYUM.tr : sAppNameTWT.tr);

    OrderPlaceGuestInfoRequest mOrderPlaceGuestInfoRequest =
        OrderPlaceGuestInfoRequest(
      userAgent: userAgent,
      browserName: browserName,
      appName: appName,
      appVersion: appVersion,
      platform: platform,
      language: language,
      appCodeName: "",
      deviceMemory: 0,
      hardwareConcurrency: 0,
      languages: [],
      maxTouchPoints: 0,
      product: sTitle,
      productSub: "",
      vendor: "",
      vendorSub: "",
    );
    await SharedPrefs().setOrderPlaceGuest(jsonEncode(mOrderPlaceGuestInfoRequest));
    print('userAgent: $userAgent\n');

    print('Browser Name: $browserName\n');

    print('Platform: $platform\n');

    print('App Name: $appName\n');

    print('App Version: $appVersion\n');

    print('Language: $language\n');
  }
}

String getBrowserName(String userAgent) {
  if (userAgent.contains("chrome") && !userAgent.contains("edg")) {
    return "Google Chrome";
  } else if (userAgent.contains("safari") && !userAgent.contains("chrome")) {
    return "Safari";
  } else if (userAgent.contains("firefox")) {
    return "Mozilla Firefox";
  } else if (userAgent.contains("edg")) {
    return "Microsoft Edge";
  } else if (userAgent.contains("opera") || userAgent.contains("opr")) {
    return "Opera";
  } else {
    return "Unknown Browser";
  }
}

String getChromeVersion(String userAgent) {
  final match = RegExp(r'chrome\/([\d.]+)').firstMatch(userAgent);
  return match != null ? match.group(1) ?? "" : "";
}
