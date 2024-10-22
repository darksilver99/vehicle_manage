import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_theme.dart';
import 'package:vehicle_manage/flutter_flow/flutter_flow_util.dart';

class SkeltonLoadView extends StatefulWidget {
  const SkeltonLoadView({super.key});

  @override
  State<SkeltonLoadView> createState() => _SkeltonLoadViewState();
}

class _SkeltonLoadViewState extends State<SkeltonLoadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: SkeletonLoader(
                    items: 6,
                    period: Duration(milliseconds: 600),
                    baseColor: FlutterFlowTheme.of(context).primaryBackground,
                    highlightColor: FlutterFlowTheme.of(context).alternate,
                    direction: SkeletonDirection.ltr,
                    builder: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
                  .divide(SizedBox(height: 8))
                  .addToStart(SizedBox(height: 8))
                  .addToEnd(SizedBox(height: 32)),
            ),
          ),
        ),
      ),
    );
  }
}
