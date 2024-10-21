import 'package:flutter/material.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_theme.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_util.dart';

buildMarker(DateTime day, List<DateTime>? dateList) {
  if (dateList == null) {
    return null;
  }
  bool containsDate = dateList.any((date) => date.year == day.year && date.month == day.month && date.day == day.day);
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: FlutterFlowTheme.of(context).error),
            ),
          );
        });
  }

  List<DateTime> matchingDates = dateList.where((date) => date.hour == 1).toList();

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
                decoration: BoxDecoration(shape: BoxShape.circle, color: FlutterFlowTheme.of(context).error),
              ),
            );
          });
    }
  }

  return null;
}
