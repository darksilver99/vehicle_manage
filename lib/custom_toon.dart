import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_manage/backend/schema/vehicle_list_record.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_theme.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_util.dart';

import 'backend/schema/rent_list_record.dart';

buildMarker(DateTime day, List<DateTime>? dateList) {
  if (dateList == null) {
    return null;
  }
  bool containsDate = dateList.any((date) =>
      date.year == day.year && date.month == day.month && date.day == day.day);
  if (containsDate) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(1),
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FlutterFlowTheme.of(context).error),
            ),
          );
        });
  }

  List<DateTime> matchingDates =
      dateList.where((date) => date.hour == 1).toList();

  if (matchingDates.isNotEmpty) {
    if (day >= matchingDates[0]) {
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(1),
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FlutterFlowTheme.of(context).error),
              ),
            );
          });
    }
  }

  return null;
}

Future<String> getCarData(DocumentReference ref) async {
  VehicleListRecord carDocumentResult =
      await VehicleListRecord.getDocumentOnce(ref);
  return "${carDocumentResult.subject} (${carDocumentResult.vehicleNumber})";
}

Future<List<RentListRecord>> getCustomerRentList(
    String customerId, DateTime currentMonth) async {
  List<RentListRecord> allRentLists = [];

  // Step 1: Get the list of vehicles under "customer"
  QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
      .collection('customer_list')
      .doc(customerId)
      .collection('vehicle_list')
      .get();

  // Step 2: For each vehicle, get its rent_list
  for (var vehicleDoc in vehicleSnapshot.docs) {
    QuerySnapshot rentListSnapshot =
        await vehicleDoc.reference.collection('rent_list').get();

    // Step 3: Filter the rent_list based on the rent_date_list containing dates in the current month
    List<RentListRecord> filteredRentList = rentListSnapshot.docs
        .map((doc) => RentListRecord.fromSnapshot(doc))
        .where((rentRecord) {
      // Filter based on whether any date in rent_date_list is within the current month
      return rentRecord.rentDateList.any((rentDate) {
        return rentDate.year == currentMonth.year &&
            rentDate.month == currentMonth.month;
      });
    }).toList();

    // Step 4: Add the filtered and sorted rent_list to the master list of all rent lists
    allRentLists.addAll(filteredRentList);
  }

  // Step 5: Sort the filtered rent_list by start_date in ascending order
  allRentLists.sort((a, b) => a.startDate!.compareTo(b.startDate!));

  return allRentLists;
}
