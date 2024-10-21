import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/other_view/confirm_repair_view/confirm_repair_view_widget.dart';
import '/other_view/info_custom_view/info_custom_view_widget.dart';
import '/vehicle_view/vehicle_form_view/vehicle_form_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'vehicle_detail_page_widget.dart' show VehicleDetailPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class VehicleDetailPageModel extends FlutterFlowModel<VehicleDetailPageWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  VehicleListRecord? vehicleDocument;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - confirmBlock] action in Container widget.
  bool? isConfirm3;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Container widget.
  bool? isConfirm;
  // Stores action output result for [Action Block - confirmBlock] action in Container widget.
  bool? isConfirm2;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}

  /// Action blocks.
  Future initVehicle(BuildContext context) async {
    VehicleListRecord? vehicleDocumentResult;

    vehicleDocumentResult =
        await VehicleListRecord.getDocumentOnce(widget!.vehicleReference!);
    vehicleDocument = vehicleDocumentResult;
  }
}
