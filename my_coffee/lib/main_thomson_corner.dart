import 'dart:io';

import 'package:f_b_base/constants/app_constants.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/data/remote/web_http_overrides.dart';
import 'package:f_b_base/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'model/app_theme/my_app_theme.dart';

const hiveDbPath = 'Thomson_Corner';

void main() async {
  AppConstants.iAccessKey = 1;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = WebHttpOverrides();
  await dotenv.load(fileName: ".env");

  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorConstants.primaryBackgroundColor,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
      const MyAppTheme(), // Wrap your app
    // ),
  );
}
