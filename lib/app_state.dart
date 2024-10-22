import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_configData')) {
        try {
          final serializedData = prefs.getString('ff_configData') ?? '{}';
          _configData =
              ConfigDataStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_customerData')) {
        try {
          final serializedData = prefs.getString('ff_customerData') ?? '{}';
          _customerData = CustomerDataStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _isSkipOCRAlert = prefs.getBool('ff_isSkipOCRAlert') ?? _isSkipOCRAlert;
    });
    _safeInit(() {
      _currentDate = prefs.containsKey('ff_currentDate')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_currentDate')!)
          : _currentDate;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  ConfigDataStruct _configData = ConfigDataStruct();
  ConfigDataStruct get configData => _configData;
  set configData(ConfigDataStruct value) {
    _configData = value;
    prefs.setString('ff_configData', value.serialize());
  }

  void updateConfigDataStruct(Function(ConfigDataStruct) updateFn) {
    updateFn(_configData);
    prefs.setString('ff_configData', _configData.serialize());
  }

  CustomerDataStruct _customerData = CustomerDataStruct();
  CustomerDataStruct get customerData => _customerData;
  set customerData(CustomerDataStruct value) {
    _customerData = value;
    prefs.setString('ff_customerData', value.serialize());
  }

  void updateCustomerDataStruct(Function(CustomerDataStruct) updateFn) {
    updateFn(_customerData);
    prefs.setString('ff_customerData', _customerData.serialize());
  }

  String _appVersion = '';
  String get appVersion => _appVersion;
  set appVersion(String value) {
    _appVersion = value;
  }

  int _appBuildVersion = 0;
  int get appBuildVersion => _appBuildVersion;
  set appBuildVersion(int value) {
    _appBuildVersion = value;
  }

  DocumentReference? _tmpVehicleRef;
  DocumentReference? get tmpVehicleRef => _tmpVehicleRef;
  set tmpVehicleRef(DocumentReference? value) {
    _tmpVehicleRef = value;
  }

  bool _isSkipOCRAlert = false;
  bool get isSkipOCRAlert => _isSkipOCRAlert;
  set isSkipOCRAlert(bool value) {
    _isSkipOCRAlert = value;
    prefs.setBool('ff_isSkipOCRAlert', value);
  }

  DateTime? _currentDate = DateTime.fromMillisecondsSinceEpoch(23599860000);
  DateTime? get currentDate => _currentDate;
  set currentDate(DateTime? value) {
    _currentDate = value;
    value != null
        ? prefs.setInt('ff_currentDate', value.millisecondsSinceEpoch)
        : prefs.remove('ff_currentDate');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
