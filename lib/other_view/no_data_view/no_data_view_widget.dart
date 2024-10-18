import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_data_view_model.dart';
export 'no_data_view_model.dart';

class NoDataViewWidget extends StatefulWidget {
  const NoDataViewWidget({super.key});

  @override
  State<NoDataViewWidget> createState() => _NoDataViewWidgetState();
}

class _NoDataViewWidgetState extends State<NoDataViewWidget> {
  late NoDataViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoDataViewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 42.0,
            ),
          ],
        ),
        Text(
          'ไม่มีข้อมูล',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Kanit',
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 24.0,
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }
}
