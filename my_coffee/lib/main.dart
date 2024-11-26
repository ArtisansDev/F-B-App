import 'dart:io';


import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/app_constants.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/data/remote/web_http_overrides.dart';
import 'package:f_b_base/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'model/app_theme/my_app_theme.dart';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
const hiveDbPath = 'TWT';

void main() async {
  AppConstants.iAccessKey = 3;
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



// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String barcode = 'Tap  to scan';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Scan Barcode'),
//               onPressed: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return AiBarcodeScanner(
//                         onDispose: () {
//                           /// This is called when the barcode scanner is disposed.
//                           /// You can write your own logic here.
//                           AppAlertBase.showSnackBar(context,"Barcode scanner disposed!");
//                         },
//                         hideGalleryButton: false,
//                         controller: MobileScannerController(
//                           detectionSpeed: DetectionSpeed.noDuplicates,
//                         ),
//                         onDetect: (BarcodeCapture capture) {
//                           /// The row string scanned barcode value
//                           final String? scannedValue =
//                               capture.barcodes.first.rawValue;
//                           AppAlertBase.showSnackBar(context,"Barcode scanned: $scannedValue");
//                           setState(() {
//                             barcode = scannedValue.toString();
//                             Get.back(result:  barcode);
//                           });
//
//                         },
//                         validator: (value) {
//                           if (value.barcodes.isEmpty) {
//                             return false;
//                           }
//                           if (!(value.barcodes.first.rawValue
//                               ?.contains('flutter.dev') ??
//                               false)) {
//                             return false;
//                           }
//                           return true;
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//             Text(barcode),
//           ],
//         ),
//       ),
//     );
//   }
// }
