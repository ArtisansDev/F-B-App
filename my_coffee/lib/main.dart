import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'constants/color_constants.dart';
import 'data/remote/web_http_overrides.dart';
import 'locator.dart';
import 'model/app_theme/my_app_theme.dart';

const hiveDbPath = 'TWT';

void main() async {
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
