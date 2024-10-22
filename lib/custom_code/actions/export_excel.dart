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
    header.add(header[i]);
  }

  for (var i = 0; i < header.length; i++) {
    var cell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1));
    cell.value = TextCellValue(header[i]);
    cell.cellStyle = cellStyle;
  }

  // body
  for (int i = 0; i < rsMember.size; i++) {
    var cell = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 2));
    cell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Left);
    cell.value = TextCellValue('${rsMember.docs[i].data()["display_name"]}');

    for (int j = 0; j < dateRange.length; j++) {
      var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: j + 1, rowIndex: i + 2));
      cell.cellStyle = CellStyle(
          textWrapping: TextWrapping.WrapText,
          verticalAlign: VerticalAlign.Top,
          horizontalAlign: HorizontalAlign.Left);

      var transactionInThisDate = filterSnapshotByDate(rs,
          DateTime(dateRange[j].year, dateRange[j].month, dateRange[j].day));
      var transactionInThisMember = filterSnapshotByMemberRef(
          transactionInThisDate, rsMember.docs[i].reference);

      //List<QueryDocumentSnapshot<Map<String, dynamic>>>
      //List<QuerySnapshot<Map<String, dynamic>>>
      if (transactionInThisMember.isNotEmpty) {
        var data = "";
        for (int k = 0; k < transactionInThisMember.length; k++) {
          //if (transactionInThisDate[k].data()["member_ref"] == rsMember.docs[i].reference) {
          var line = "";
          if (k > 0) {
            line = "------------------------------\n";
          }
          if (transactionInThisMember[k].data()["status"] == 3) {
            data =
                "$data$line${transactionInThisMember[k].data()["detail_in"]}\n";
          } else {
            // เวลา
            var dateIn = dateTimeFormat(
                'Hm', transactionInThisMember[k].data()["date_in"].toDate());
            var dateOut =
                transactionInThisMember[k].data().containsKey("date_out")
                    ? dateTimeFormat('Hm',
                        transactionInThisMember[k].data()["date_out"].toDate())
                    : "-";

            if (dateOut != "-") {
              if (functions.checkIsDateAfter(
                  transactionInThisMember[k].data()["date_out"].toDate(),
                  transactionInThisMember[k].data()["date_in"].toDate())) {
                dateOut = functions.dateTimeTh(
                    transactionInThisMember[k].data()["date_out"].toDate())!;
              }
            }

            var startEndTimeText = "เข้างาน : $dateIn | ออกงาน : $dateOut";

            //รายละเอียด
            var detailIn =
                transactionInThisMember[k].data().containsKey("detail_in")
                    ? transactionInThisMember[k].data()["detail_in"]
                    : "";
            var detailOut =
                transactionInThisMember[k].data().containsKey("detail_out")
                    ? transactionInThisMember[k].data()["detail_out"]
                    : "";
            var startEndDetailText =
                "รายละเอียด(เข้างาน) : ${(detailIn != '') ? detailIn : " -"}\n รายละเอียด(ออกงาน) : ${(detailOut != '') ? detailOut : " -"}";

            //ระยะเวลา
            var durationText = "";
            if (transactionInThisMember[k].data().containsKey("date_out")) {
              durationText =
                  "ระยะเวลาทำงาน : ${functions.formatDuration(functions.millisecondsBetween(transactionInThisMember[k].data()["date_in"].toDate(), transactionInThisMember[k].data()["date_out"].toDate()))}";
            }

            //รูป
            //ไม่ได้ hyper link ไม่ร้องรับ บางส่วนของ string ใน 1 ช่อง อาจต้องเป็นทั้งช่องไปเลย
            /*var photoIn = transactionInThisMember[k].data().containsKey("photo_in") ? transactionInThisMember[k].data()["photo_in"] : "";
            var photoOut = transactionInThisMember[k].data().containsKey("photo_out") ? transactionInThisMember[k].data()["photo_out"] : "";
            String hyperlinkIn = (photoIn != '') ? '=HYPERLINK("$photoIn", "ดูรูป")' : " -";
            String hyperlinkOut = (photoOut != '') ? '=HYPERLINK("$photoOut", "ดูรูป")' : " -";
            var startEndPhotoText = "รูป(เข้างาน) : $hyperlinkIn\n รูป(ออกงาน) : $hyperlinkOut";*/
            data =
                "$data$line$startEndTimeText\n$startEndDetailText\n$durationText\n";
          }
          //}
        }
        cell.value = TextCellValue(data);
      }
    }
  }

  // Auto-size columns
  for (int col = 0; col < 60; col++) {
    //sheetObject.setColumnWidth(col, 2000);
    sheetObject.setDefaultColumnWidth(25);
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
