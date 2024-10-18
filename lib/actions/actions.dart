import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/other_view/confirm_custom_view/confirm_custom_view_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

Future initConfig(BuildContext context) async {
  ConfigRecord? configResult;

  configResult = await queryConfigRecordOnce(
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  FFAppState().configData = ConfigDataStruct(
    contact: configResult?.contact,
    freeDay: configResult?.freeDay,
    isReview: configResult?.isReview,
    ocrAlertText: configResult?.ocrAlertText,
    ocrApi: configResult?.ocrApi,
    ocrErrorText: configResult?.ocrErrorText,
    paymentAlertText: configResult?.paymentAlertText,
    paymentDetailImage: configResult?.paymentDetailImage,
    policyUrl: configResult?.policyUrl,
    promotionDetailImage: configResult?.promotionDetailImage,
    storeAndroidLink: configResult?.storeAndroidLink,
    storeIosLink: configResult?.storeIosLink,
    storeVersion: configResult?.storeVersion,
  );
}

Future initCustomer(BuildContext context) async {
  CustomerListRecord? customerResult;

  customerResult = await queryCustomerListRecordOnce(
    queryBuilder: (customerListRecord) => customerListRecord.where(
      'create_by',
      isEqualTo: currentUserReference,
    ),
    singleRecord: true,
  ).then((s) => s.firstOrNull);
  if (customerResult != null) {
    FFAppState().customerData = CustomerDataStruct(
      expireDate: customerResult?.expireDate,
      customerRef: customerResult?.reference,
      maxVehicle: customerResult?.maxVehicle,
      customerName: customerResult?.customerName,
    );
  } else {
    await CustomerListRecord.collection.doc().set(createCustomerListRecordData(
          createDate: getCurrentTimestamp,
          createBy: currentUserReference,
          status: 1,
          expireDate: functions.getEndDayTime(functions.getNextDay(
              FFAppState().configData.freeDay, getCurrentTimestamp)),
          customerName: currentUserEmail,
          maxVehicle: 10,
        ));
    await action_blocks.initCustomer(context);
  }
}

Future<bool?> confirmBlock(
  BuildContext context, {
  required String? title,
  String? detail,
}) async {
  bool? isConfirm;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: WebViewAware(
          child: ConfirmCustomViewWidget(
            title: title!,
            detail: detail,
          ),
        ),
      );
    },
  ).then((value) => isConfirm = value);

  if ((isConfirm != null) && isConfirm!) {
    return true;
  }

  return false;
}
