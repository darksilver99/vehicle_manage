// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VehicleDataStruct extends FFFirebaseStruct {
  VehicleDataStruct({
    DocumentReference? docRef,
    String? subject,
    String? vehicleNumber,
    String? image,
    int? status,
    String? statusText,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _docRef = docRef,
        _subject = subject,
        _vehicleNumber = vehicleNumber,
        _image = image,
        _status = status,
        _statusText = statusText,
        super(firestoreUtilData);

  // "doc_ref" field.
  DocumentReference? _docRef;
  DocumentReference? get docRef => _docRef;
  set docRef(DocumentReference? val) => _docRef = val;

  bool hasDocRef() => _docRef != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  set subject(String? val) => _subject = val;

  bool hasSubject() => _subject != null;

  // "vehicle_number" field.
  String? _vehicleNumber;
  String get vehicleNumber => _vehicleNumber ?? '';
  set vehicleNumber(String? val) => _vehicleNumber = val;

  bool hasVehicleNumber() => _vehicleNumber != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "status_text" field.
  String? _statusText;
  String get statusText => _statusText ?? '';
  set statusText(String? val) => _statusText = val;

  bool hasStatusText() => _statusText != null;

  static VehicleDataStruct fromMap(Map<String, dynamic> data) =>
      VehicleDataStruct(
        docRef: data['doc_ref'] as DocumentReference?,
        subject: data['subject'] as String?,
        vehicleNumber: data['vehicle_number'] as String?,
        image: data['image'] as String?,
        status: castToType<int>(data['status']),
        statusText: data['status_text'] as String?,
      );

  static VehicleDataStruct? maybeFromMap(dynamic data) => data is Map
      ? VehicleDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'doc_ref': _docRef,
        'subject': _subject,
        'vehicle_number': _vehicleNumber,
        'image': _image,
        'status': _status,
        'status_text': _statusText,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'doc_ref': serializeParam(
          _docRef,
          ParamType.DocumentReference,
        ),
        'subject': serializeParam(
          _subject,
          ParamType.String,
        ),
        'vehicle_number': serializeParam(
          _vehicleNumber,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'status_text': serializeParam(
          _statusText,
          ParamType.String,
        ),
      }.withoutNulls;

  static VehicleDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      VehicleDataStruct(
        docRef: deserializeParam(
          data['doc_ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['customer_list', 'vehicle_list'],
        ),
        subject: deserializeParam(
          data['subject'],
          ParamType.String,
          false,
        ),
        vehicleNumber: deserializeParam(
          data['vehicle_number'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        statusText: deserializeParam(
          data['status_text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VehicleDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VehicleDataStruct &&
        docRef == other.docRef &&
        subject == other.subject &&
        vehicleNumber == other.vehicleNumber &&
        image == other.image &&
        status == other.status &&
        statusText == other.statusText;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([docRef, subject, vehicleNumber, image, status, statusText]);
}

VehicleDataStruct createVehicleDataStruct({
  DocumentReference? docRef,
  String? subject,
  String? vehicleNumber,
  String? image,
  int? status,
  String? statusText,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VehicleDataStruct(
      docRef: docRef,
      subject: subject,
      vehicleNumber: vehicleNumber,
      image: image,
      status: status,
      statusText: statusText,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VehicleDataStruct? updateVehicleDataStruct(
  VehicleDataStruct? vehicleData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    vehicleData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVehicleDataStructData(
  Map<String, dynamic> firestoreData,
  VehicleDataStruct? vehicleData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (vehicleData == null) {
    return;
  }
  if (vehicleData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && vehicleData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final vehicleDataData =
      getVehicleDataFirestoreData(vehicleData, forFieldValue);
  final nestedData =
      vehicleDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = vehicleData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVehicleDataFirestoreData(
  VehicleDataStruct? vehicleData, [
  bool forFieldValue = false,
]) {
  if (vehicleData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(vehicleData.toMap());

  // Add any Firestore field values
  vehicleData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVehicleDataListFirestoreData(
  List<VehicleDataStruct>? vehicleDatas,
) =>
    vehicleDatas?.map((e) => getVehicleDataFirestoreData(e, true)).toList() ??
    [];
