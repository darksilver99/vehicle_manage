import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RepairListRecord extends FirestoreRecord {
  RepairListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _detail = snapshotData['detail'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('${FFAppState().tmpVehicleRef}/repair_list');

  static Stream<RepairListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RepairListRecord.fromSnapshot(s));

  static Future<RepairListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RepairListRecord.fromSnapshot(s));

  static RepairListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RepairListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RepairListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RepairListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RepairListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RepairListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRepairListRecordData({
  DateTime? createDate,
  String? detail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'detail': detail,
    }.withoutNulls,
  );

  return firestoreData;
}

class RepairListRecordDocumentEquality implements Equality<RepairListRecord> {
  const RepairListRecordDocumentEquality();

  @override
  bool equals(RepairListRecord? e1, RepairListRecord? e2) {
    return e1?.createDate == e2?.createDate && e1?.detail == e2?.detail;
  }

  @override
  int hash(RepairListRecord? e) =>
      const ListEquality().hash([e?.createDate, e?.detail]);

  @override
  bool isValidKey(Object? o) => o is RepairListRecord;
}
