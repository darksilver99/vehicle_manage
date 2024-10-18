import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VehicleListRecord extends FirestoreRecord {
  VehicleListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "create_date" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "subject" field.
  String? _subject;
  String get subject => _subject ?? '';
  bool hasSubject() => _subject != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "vehicle_number" field.
  String? _vehicleNumber;
  String get vehicleNumber => _vehicleNumber ?? '';
  bool hasVehicleNumber() => _vehicleNumber != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _status = castToType<int>(snapshotData['status']);
    _subject = snapshotData['subject'] as String?;
    _detail = snapshotData['detail'] as String?;
    _vehicleNumber = snapshotData['vehicle_number'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('vehicle_list')
          : FirebaseFirestore.instance.collectionGroup('vehicle_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('vehicle_list').doc(id);

  static Stream<VehicleListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VehicleListRecord.fromSnapshot(s));

  static Future<VehicleListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VehicleListRecord.fromSnapshot(s));

  static VehicleListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      VehicleListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VehicleListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VehicleListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VehicleListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VehicleListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVehicleListRecordData({
  DateTime? createDate,
  int? status,
  String? subject,
  String? detail,
  String? vehicleNumber,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'status': status,
      'subject': subject,
      'detail': detail,
      'vehicle_number': vehicleNumber,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class VehicleListRecordDocumentEquality implements Equality<VehicleListRecord> {
  const VehicleListRecordDocumentEquality();

  @override
  bool equals(VehicleListRecord? e1, VehicleListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.status == e2?.status &&
        e1?.subject == e2?.subject &&
        e1?.detail == e2?.detail &&
        e1?.vehicleNumber == e2?.vehicleNumber &&
        e1?.image == e2?.image;
  }

  @override
  int hash(VehicleListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.status,
        e?.subject,
        e?.detail,
        e?.vehicleNumber,
        e?.image
      ]);

  @override
  bool isValidKey(Object? o) => o is VehicleListRecord;
}
