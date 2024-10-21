import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? dateTh(DateTime? date) {
  if (date == null) {
    return null;
  }
  final DateFormat formatter = DateFormat('d MMMM yyyy', 'th_TH');
  final buddhistYear = date.year + 543;
  return formatter.format(date).replaceFirst('${date.year}', '$buddhistYear');
}

String? dateTimeTh(DateTime? date) {
  if (date == null) {
    return null;
  }

  final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm:ss', 'th_TH');
  final buddhistYear = date.year + 543;
  return formatter.format(date).replaceFirst('${date.year}', '$buddhistYear');
}

String? dayTh(DateTime date) {
  final DateFormat dayFormatter = DateFormat('EEEE', 'th_TH'); // วันของสัปดาห์
  final DateFormat dayOfMonthFormatter = DateFormat('d'); // วันของเดือน
  final DateFormat monthYearFormatter =
      DateFormat('MMMM yyyy', 'th_TH'); // เดือนและปี

  // แปลงวันที่เป็นรูปแบบที่ต้องการ
  final String dayOfWeek =
      dayFormatter.format(date); // วันของสัปดาห์ (เช่น วันจันทร์)
  final String dayOfMonth =
      dayOfMonthFormatter.format(date); // วันของเดือน (เช่น 15)

  // สร้างสตริงที่รวมวันและวันที่
  return '$dayOfWeekที่ $dayOfMonth';
}

String? fullThaiDate(DateTime? date) {
  if (date == null) {
    return null;
  }
  List<String> days = [
    'วันอาทิตย์',
    'วันจันทร์',
    'วันอังคาร',
    'วันพุธ',
    'วันพฤหัสบดี',
    'วันศุกร์',
    'วันเสาร์'
  ];
  List<String> months = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  // แปลงปีให้เป็นพุทธศักราช
  int buddhistYear = date.year + 543;

  // แปลงเดือน
  String month = months[date.month - 1];

  // ประกอบเป็นวันที่ที่ต้องการ
  return '${days[date.weekday - 1]}ที่ ${date.day} $month $buddhistYear';
}

DateTime getBeforeDay(
  int pastDay,
  DateTime date,
) {
  DateTime pastDate = date.subtract(Duration(days: pastDay));
  return pastDate;
}

DateTime getEndDayTime(DateTime currentDate) {
  DateTime endOfDay = DateTime(
      currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);
  return endOfDay;
}

DateTime getNextDay(
  int nextDay,
  DateTime dateTime,
) {
  DateTime newDate = dateTime.add(Duration(days: nextDay));
  return DateTime(newDate.year, newDate.month, newDate.day);
}

DateTime getStartDayTime(DateTime currentDate) {
  DateTime startOfDay =
      DateTime(currentDate.year, currentDate.month, currentDate.day);
  return startOfDay;
}

String? getStatusText(
  int status,
  List<DataStatusStruct> statusList,
) {
  for (var dataStatus in statusList) {
    if (dataStatus.status == status) {
      return dataStatus.subject;
    }
  }
  return '-';
}

List<VehicleDataStruct> filterVehicleList(
  String keyword,
  List<VehicleDataStruct> vehicleList,
) {
  String lowerCaseKeyword = keyword.toLowerCase();
  List<VehicleDataStruct> searchedList = vehicleList.where((doc) {
    return doc.subject.toLowerCase().contains(lowerCaseKeyword) ||
        doc.vehicleNumber.toLowerCase().contains(lowerCaseKeyword);
  }).toList();
  return searchedList;
}

List<DateTime> getDateList(
  DateTime startDate,
  DateTime endDate,
) {
  List<DateTime> dateList = [];

  DateTime currentDate =
      DateTime(startDate.year, startDate.month, startDate.day);

  while (
      currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
    dateList
        .add(DateTime(currentDate.year, currentDate.month, currentDate.day));
    currentDate = currentDate.add(Duration(days: 1));
  }

  return dateList;
}
