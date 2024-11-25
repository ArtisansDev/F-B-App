// ignore_for_file: depend_on_referenced_packages

/*
 * Project      : skill-360
 * File         : date_format.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-24
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getDatePicker(BuildContext context, Function getDate) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //get today's date
      firstDate: DateTime(2000),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101));

  if (pickedDate != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    getDate(getDateDDMMYYYY(formattedDate));
  }
}

getDateDDMMYYYY(String value) {
  if (value.isEmpty) {
    return '';
  }
  DateTime tempDate = DateFormat("yyyy-MM-dd").parse(value);
  var inputDate = DateTime.parse(tempDate.toString());
  var outputFormat = DateFormat('dd-MM-yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate.toString();
}

getDateMMDDYYYY(String value) {
  if (value.isEmpty) {
    return '';
  }
  DateTime tempDate = DateFormat("dd-MM-yyyy").parse(value);
  var inputDate = DateTime.parse(tempDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate.toString();
}

getDateMMDDYYYYFromYYYYMMdd(String value) {
  if (value.isEmpty) {
    return '';
  }
  DateTime tempDate = DateFormat("yyyy-MM-dd").parse(value);
  var inputDate = DateTime.parse(tempDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate.toString();
}

getDateMMYYYY(DateTime selected) {
  String sDate =
      '${selected.month.toString().padLeft(2, '0')}/${selected.year.toString()}';
  return sDate;
}

getDateMMYYYYTime(DateTime selected) {
  String formattedTime = DateFormat('hh:mm a').format(selected);
  String sDate =
      '${selected.day.toString().padLeft(2, '0')}-${selected.month.toString().padLeft(2, '0')}-${selected.year.toString()}  $formattedTime';
  return sDate;
}

toDateCompare(String sStartDate, String sEndDate) {
  var dateFormat = DateFormat('dd-MM-yyyy');
  DateTime startDate = dateFormat.parse(sStartDate);
  DateTime endDate = dateFormat.parse(sEndDate);
  return endDate.compareTo(startDate) == 1;
}

toDayDate() {
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  return date;
}

String time24to12Format(String time) {
  var timeList = time.split(":");
  int h = int.parse(timeList.first);
  int m = 0;
  if (timeList.length > 2) {
    m = int.parse(timeList[1]);
  }

  String send = "";
  if (h > 12) {
    var temp = h - 12;
    send =
        "$temp:${m.toString().length == 1 ? m.toString().padLeft(2, '0') : m.toString().padLeft(2, '0')} "
        "PM";
  } else {
    send =
        "$h:${m.toString().length == 1 ? m.toString().padLeft(2, '0') : m.toString().padLeft(2, '0')} "
        "AM";
  }

  return send;
}

bool timeCheck(String fromTime, String toTime) {
  DateTime currentTime = DateTime.now();
  var fromTimeList = fromTime.split(":");
  int h = int.parse(fromTimeList.first);
  int m = 0;

  if (fromTimeList.length > 2) {
    m = int.parse(fromTimeList[1]);
  }
  DateTime nineAM =
      DateTime(currentTime.year, currentTime.month, currentTime.day, h, m);

  fromTimeList = toTime.split(":");
  h = int.parse(fromTimeList.first);
  m = 0;
  if (fromTimeList.length > 2) {
    m = int.parse(fromTimeList[1]);
  }

  DateTime fivePM =
      DateTime(currentTime.year, currentTime.month, currentTime.day, h, m);

  if (currentTime.isAfter(nineAM) && currentTime.isBefore(fivePM)) {
    print(
        "The time is within working hours (${time24to12Format(fromTime)} - ${time24to12Format(toTime)}).");
    return true;
  } else {
    print("The time is outside of working hours.");
    return false;
  }
}

getUTCValue(DateTime selected) {
  String value = selected.toUtc().toIso8601String().toString();
  return value;
}

getUTCToLocalValue(String sValue) {
 return DateTime.parse(sValue).toLocal();
}

getUTCToLocalDateOrderHistory(String sValue) {
  DateTime selected=  DateTime.parse(sValue).toLocal();
  String formattedTime = DateFormat('hh:mm a').format(selected);
  String sDate =
      '${selected.day.toString().padLeft(2, '0')}-${selected.month.toString().padLeft(2, '0')}-${selected.year.toString()}  $formattedTime';
  return sDate;
}

getUTCToLocalDateTime(String sValue) {
  DateTime selected=  DateTime.parse(sValue).toLocal();
  String formattedTime = DateFormat('hh:mm a').format(selected);
  String sDate =
      '${selected.day.toString().padLeft(2, '0')}-${selected.month.toString().padLeft(2, '0')}-${selected.year.toString()} | $formattedTime';
  return sDate;
}