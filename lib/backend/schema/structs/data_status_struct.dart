// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataStatusStruct extends FFFirebaseStruct {
  DataStatusStruct({
    int? status,
    String? subject,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _subject = subject,
        super(firestoreUtilData);

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  set subject(String? val) => _subject = val;

  bool hasSubject() => _subject != null;

  static DataStatusStruct fromMap(Map<String, dynamic> data) =>
      DataStatusStruct(
        status: castToType<int>(data['status']),
        subject: data['subject'] as String?,
      );

  static DataStatusStruct? maybeFromMap(dynamic data) => data is Map
      ? DataStatusStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'subject': _subject,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'subject': serializeParam(
          _subject,
          ParamType.String,
        ),
      }.withoutNulls;

  static DataStatusStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataStatusStruct(
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        subject: deserializeParam(
          data['subject'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DataStatusStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataStatusStruct &&
        status == other.status &&
        subject == other.subject;
  }

  @override
  int get hashCode => const ListEquality().hash([status, subject]);
}

DataStatusStruct createDataStatusStruct({
  int? status,
  String? subject,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataStatusStruct(
      status: status,
      subject: subject,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataStatusStruct? updateDataStatusStruct(
  DataStatusStruct? dataStatus, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataStatus
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataStatusStructData(
  Map<String, dynamic> firestoreData,
  DataStatusStruct? dataStatus,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dataStatus == null) {
    return;
  }
  if (dataStatus.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataStatus.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dataStatusData = getDataStatusFirestoreData(dataStatus, forFieldValue);
  final nestedData = dataStatusData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataStatus.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataStatusFirestoreData(
  DataStatusStruct? dataStatus, [
  bool forFieldValue = false,
]) {
  if (dataStatus == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dataStatus.toMap());

  // Add any Firestore field values
  dataStatus.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDataStatusListFirestoreData(
  List<DataStatusStruct>? dataStatuss,
) =>
    dataStatuss?.map((e) => getDataStatusFirestoreData(e, true)).toList() ?? [];
