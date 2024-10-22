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
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await action_blocks.initConfig(context);
      await actions.setAppVersion();
      if (FFAppState().appBuildVersion >=
          FFAppState().configData.storeVersion) {
        await action_blocks.initCustomer(context);
        await _model.initVehicle(context);
        await _model.checkCuurentDate(context);
        _model.isLoading = false;
        safeSetState(() {});
      } else {
        await showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: WebViewAware(
                child: GestureDetector(
                  onTap: () => FocusScope.of(dialogContext).unfocus(),
                  child: InfoCustomViewWidget(
                    title: 'กรุณาอัพเดทแอปพลิเคชั่นและเปิดใหม่อีกครั้ง',
                    status: 'error',
                  ),
                ),
              ),
            );
          },
        );

        if (isAndroid) {
          await launchURL(FFAppState().configData.storeAndroidLink);
        } else {
          await launchURL(FFAppState().configData.storeIosLink);
        }

        await actions.closeApp();
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton.extended(
              onPressed: () async {
                await actions.hideKeyBoard(
                  context,
                );
                _model.totelVehicle = await queryVehicleListRecordCount(
                  parent: FFAppState().customerData.customerRef,
                  queryBuilder: (vehicleListRecord) =>
                      vehicleListRecord.whereIn('status', [1, 3]),
                );
                if (_model.totelVehicle! <
                    FFAppState().customerData.maxVehicle) {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: VehicleFormViewWidget(),
                          ),
                        ),
                      );
                    },
                  ).then(
                      (value) => safeSetState(() => _model.isUpdate = value));

                  if ((_model.isUpdate != null && _model.isUpdate != '') &&
                      (_model.isUpdate == 'update')) {
                    await _model.initVehicle(context);
                  }
                } else {
                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: WebViewAware(
                          child: GestureDetector(
                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                            child: InfoCustomViewWidget(
                              title:
                                  'บัญชีของท่านกำหนดรถไม่เกิน ${FFAppState().customerData.maxVehicle.toString()} รายการ',
                              detail:
                                  'สอบถามข้อมูลเพิ่มเติมที่เมนู \"Contact Us\"',
                              status: 'error',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                safeSetState(() {});
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.add_rounded,
              ),
              elevation: 8.0,
              label: Text(
                'เพิ่มรถ',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Kanit',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              Duration(milliseconds: 100),
                              () async {
                                if (_model.textController.text != null &&
                                    _model.textController.text != '') {
                                  _model.vehicleList = functions
                                      .filterVehicleList(
                                          _model.textController.text,
                                          _model.tmpVehicleList.toList())
                                      .toList()
                                      .cast<VehicleDataStruct>();
                                  safeSetState(() {});
                                } else {
                                  _model.vehicleList = _model.tmpVehicleList
                                      .toList()
                                      .cast<VehicleDataStruct>();
                                  safeSetState(() {});
                                }
                              },
                            ),
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Kanit',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'ค้นหา ชื่อ, ทะเบียน',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Kanit',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Kanit',
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_model.isLoading)
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final vehicleViewList = _model.vehicleList.toList();
                        if (vehicleViewList.isEmpty) {
                          return NoDataViewWidget();
                        }

                        return RefreshIndicator(
                          onRefresh: () async {
                            _model.isLoading = true;
                            safeSetState(() {});
                            await _model.initVehicle(context);
                            _model.isLoading = false;
                            safeSetState(() {});
                          },
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              16.0,
                              0,
                              180.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: vehicleViewList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 8.0),
                            itemBuilder: (context, vehicleViewListIndex) {
                              final vehicleViewListItem =
                                  vehicleViewList[vehicleViewListIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await actions.hideKeyBoard(
                                      context,
                                    );

                                    await context.pushNamed(
                                      'VehicleDetailPage',
                                      queryParameters: {
                                        'vehicleReference': serializeParam(
                                          vehicleViewListItem.docRef,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );

                                    _model.isLoading = true;
                                    safeSetState(() {});
                                    await _model.initVehicle(context);
                                    _model.isLoading = false;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 8.0, 8.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              vehicleViewListItem.image,
                                              width: 80.0,
                                              height: 80.0,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/error_image.jpg',
                                                width: 80.0,
                                                height: 80.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    '(${vehicleViewListItem.vehicleNumber}) ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    vehicleViewListItem
                                                                        .subject,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  fontSize:
                                                                      22.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'สถานะ : ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text: vehicleViewListItem
                                                                    .statusText,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Kanit',
                                                                      color:
                                                                          () {
                                                                        if (vehicleViewListItem.statusText ==
                                                                            'ปรับปรุง') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .warning;
                                                                        } else if (vehicleViewListItem.statusText ==
                                                                            'ว่าง') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .success;
                                                                        } else if (vehicleViewListItem.statusText ==
                                                                            'ว่างในวันนี้') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .info;
                                                                        } else {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .error;
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              )
                                                            ],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Kanit',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.navigate_next_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
