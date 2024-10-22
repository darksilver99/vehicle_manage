import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/other_view/info_custom_view/info_custom_view_widget.dart';
import '/other_view/no_data_view/no_data_view_widget.dart';
import '/vehicle_view/vehicle_form_view/vehicle_form_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  List<VehicleDataStruct> vehicleList = [];
  void addToVehicleList(VehicleDataStruct item) => vehicleList.add(item);
  void removeFromVehicleList(VehicleDataStruct item) =>
      vehicleList.remove(item);
  void removeAtIndexFromVehicleList(int index) => vehicleList.removeAt(index);
  void insertAtIndexInVehicleList(int index, VehicleDataStruct item) =>
      vehicleList.insert(index, item);
  void updateVehicleListAtIndex(
          int index, Function(VehicleDataStruct) updateFn) =>
      vehicleList[index] = updateFn(vehicleList[index]);

  int vehicleIndex = 0;

  bool isLoading = true;

  List<VehicleDataStruct> tmpVehicleList = [];
  void addToTmpVehicleList(VehicleDataStruct item) => tmpVehicleList.add(item);
  void removeFromTmpVehicleList(VehicleDataStruct item) =>
      tmpVehicleList.remove(item);
  void removeAtIndexFromTmpVehicleList(int index) =>
      tmpVehicleList.removeAt(index);
  void insertAtIndexInTmpVehicleList(int index, VehicleDataStruct item) =>
      tmpVehicleList.insert(index, item);
  void updateTmpVehicleListAtIndex(
          int index, Function(VehicleDataStruct) updateFn) =>
      tmpVehicleList[index] = updateFn(tmpVehicleList[index]);

  String statusText = '-';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? totelVehicle;
  // Stores action output result for [Bottom Sheet - VehicleFormView] action in FloatingActionButton widget.
  String? isUpdate;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks.
  Future initVehicle(BuildContext context) async {
    List<VehicleListRecord>? vehicleResult;
    String? statusText;

    vehicleResult = await queryVehicleListRecordOnce(
      parent: FFAppState().customerData.customerRef,
      queryBuilder: (vehicleListRecord) =>
          vehicleListRecord.whereIn('status', [1, 3]).orderBy('subject'),
    );
    vehicleIndex = 0;
    vehicleList = [];
    while (vehicleIndex < vehicleResult!.length) {
      if (vehicleResult?[vehicleIndex]?.status == 3) {
        statusText = 'ปรับปรุง';
      } else {
        statusText = await actions.getIsFreeToday(
          vehicleResult![vehicleIndex].reference,
        );
        statusText = statusText!;
      }

      addToVehicleList(VehicleDataStruct(
        docRef: vehicleResult?[vehicleIndex]?.reference,
        subject: vehicleResult?[vehicleIndex]?.subject,
        vehicleNumber: vehicleResult?[vehicleIndex]?.vehicleNumber,
        image: vehicleResult?[vehicleIndex]?.image,
        status: vehicleResult?[vehicleIndex]?.status,
        statusText: statusText,
      ));
      vehicleIndex = vehicleIndex + 1;
    }
    tmpVehicleList = vehicleList.toList().cast<VehicleDataStruct>();
  }

  Future checkCuurentDate(BuildContext context) async {
    if (functions.getStartDayTime(getCurrentTimestamp) !=
        functions.getStartDayTime(FFAppState().currentDate!)) {
      FFAppState().currentDate = functions.getStartDayTime(getCurrentTimestamp);
      FFAppState().isSkipOCRAlert = false;
    }
  }
}
