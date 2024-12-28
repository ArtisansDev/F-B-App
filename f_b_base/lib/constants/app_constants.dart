import 'package:get/get.dart';

class AppConstants {
  static int iAccessKey = 0;
  static RxInt iAccessKeyValue = 0.obs;

  // Mobile OS Platform
  // static  String seatIDF = "";
  static const String platformAndroid = "ANDROID";
  static const String platformIOS = "IOS";

  ///live url
  static const bool isLiveURLToUse = true;

  ///Web Log
  static const bool isWebLogToPrint = false;

  ///Assessment type
  static const String assessmentCompleted = "Completed";
}
