// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:excel/excel.dart';
import 'package:excel/excel.dart' as exBorder;
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:vehicle_manage/custom_toon.dart';

Future<String> exportExcel(
  DateTime? startDate,
  DateTime? endDate,
  DocumentReference customerRef,
) async {
  // Add your function code here!
  bool isGranted = false;
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    if (int.parse(info.version.release) >= 13) {
      isGranted = true;
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        isGranted = true;
      }
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      isGranted = true;
    }
  }

  if (!isGranted) {
    return '';
  }

  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  CellStyle cellStyle = CellStyle(
    backgroundColorHex: ExcelColor.fromHexString("#1AFF1A"),
    horizontalAlign: HorizontalAlign.Center,
    bold: true,
    leftBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    rightBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    topBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
    bottomBorder: exBorder.Border(borderStyle: exBorder.BorderStyle.Thin),
  );

  // Add headers
  List<String> header = [
    "ชื่อ-สกุลผู้เช่า",
    "เลขประจำตัวประชาชน",
    "เบอร์โทรศัพท์",
    "วันที่เช่า",
    "รถ",
    "สถานะ",
    "วันที่ชำระเงิน",
    "จำนวน",
    "หลักฐานการชำระเงิน"
  ];

  // title
  var cell =
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
  cell.value = TextCellValue(
      'รายงานสรุปการเช่า ประจำวันที่ ${functions.dateTh(startDate)} ถึง ${functions.dateTh(endDate)}');
  cell.cellStyle = CellStyle(fontSize: 22, bold: true);

  for (var i = 0; i < header.length; i++) {
    var cell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1));
    cell.value = TextCellValue(header[i]);
    cell.cellStyle = cellStyle;
  }

  // body

  List<RentListRecord> dataList =
      await getCustomerRentList(customerRef.id, startDate!);

  for (int i = 0; i < dataList.length; i++) {
    var rentRecord = dataList[i];

    // Set each value in the corresponding column
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 2))
      ..value = TextCellValue("${rentRecord.firstName} ${rentRecord.lastName}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 2))
      ..value = TextCellValue(" ${rentRecord.idCardNumber}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 2))
      ..value = TextCellValue(" ${rentRecord.phoneNumber}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 2))
      ..value = TextCellValue(
          "${functions.dateTh(rentRecord.startDate)} - ${functions.dateTh(rentRecord.endDate)}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

    String carData = await getCarData(rentRecord.reference.parent.parent!);
    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 2))
      ..value = TextCellValue(carData)
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

    var statusCell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 2));
    if (rentRecord.rentPaymentDate != null) {
      statusCell.value = TextCellValue("ชำระเงินแล้ว");
      statusCell.cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        fontColorHex: ExcelColor.fromHexString("#008000"),
      );
    } else {
      statusCell.value = TextCellValue("ยังไม่ชำระเงิน");
      statusCell.cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        fontColorHex: ExcelColor.fromHexString("#FF0000"),
      );
    }

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 2))
      ..value = TextCellValue(
          "${(rentRecord.rentPaymentDate != null) ? functions.dateTimeTh(rentRecord.rentPaymentDate) : "-"}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 2))
      ..value = TextCellValue(
          "${(rentRecord.rentPaymentDate != null) ? rentRecord.rentPrice : "-"}")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 2))
      ..value = rentRecord.rentPaymentDate != null &&
              rentRecord.rentPaymentSlip.isNotEmpty
          ? FormulaCellValue(
              'HYPERLINK("${rentRecord.rentPaymentSlip}", "ดูสลิป")')
          : TextCellValue("-")
      ..cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
  }

  // Auto-size columns
  for (int col = 0; col < 10; col++) {
    //sheetObject.setColumnWidth(col, 2000);
    sheetObject.setDefaultColumnWidth(30);
    //sheetObject.setColumnAutoFit(col);
  }

  Directory dir = await getApplicationDocumentsDirectory();
  //Directory dir = Directory('/storage/emulated/0/Download');
  List<int>? fileBytes = excel.save();
  var path = File(
      '${dir.path}/รายงานสรุปการเช่า${functions.dateTh(startDate)}ถึง${functions.dateTh(endDate)}.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  print(path);

  return path.path;
}
