import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RentListRecord extends FirestoreRecord {
  RentListRecord._(
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

  // "vehicle_ref" field.
  DocumentReference? _vehicleRef;
  DocumentReference? get vehicleRef => _vehicleRef;
  bool hasVehicleRef() => _vehicleRef != null;

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  bool hasLastName() => _lastName != null;

  // "id_card_number" field.
  String? _idCardNumber;
  String get idCardNumber => _idCardNumber ?? '';
  bool hasIdCardNumber() => _idCardNumber != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "remark" field.
  String? _remark;
  String get remark => _remark ?? '';
  bool hasRemark() => _remark != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "card_detail" field.
  String? _cardDetail;
  String get cardDetail => _cardDetail ?? '';
  bool hasCardDetail() => _cardDetail != null;

  // "rent_payment_date" field.
  DateTime? _rentPaymentDate;
  DateTime? get rentPaymentDate => _rentPaymentDate;
  bool hasRentPaymentDate() => _rentPaymentDate != null;

  // "rent_payment_slip" field.
  String? _rentPaymentSlip;
  String get rentPaymentSlip => _rentPaymentSlip ?? '';
  bool hasRentPaymentSlip() => _rentPaymentSlip != null;

  // "rent_price" field.
  double? _rentPrice;
  double get rentPrice => _rentPrice ?? 0.0;
  bool hasRentPrice() => _rentPrice != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _createDate = snapshotData['create_date'] as DateTime?;
    _status = castToType<int>(snapshotData['status']);
    _vehicleRef = snapshotData['vehicle_ref'] as DocumentReference?;
    _firstName = snapshotData['first_name'] as String?;
    _lastName = snapshotData['last_name'] as String?;
    _idCardNumber = snapshotData['id_card_number'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _remark = snapshotData['remark'] as String?;
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _cardDetail = snapshotData['card_detail'] as String?;
    _rentPaymentDate = snapshotData['rent_payment_date'] as DateTime?;
    _rentPaymentSlip = snapshotData['rent_payment_slip'] as String?;
    _rentPrice = castToType<double>(snapshotData['rent_price']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('rent_list')
          : FirebaseFirestore.instance.collectionGroup('rent_list');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('rent_list').doc(id);

  static Stream<RentListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RentListRecord.fromSnapshot(s));

  static Future<RentListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RentListRecord.fromSnapshot(s));

  static RentListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RentListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RentListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RentListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RentListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RentListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRentListRecordData({
  DateTime? createDate,
  int? status,
  DocumentReference? vehicleRef,
  String? firstName,
  String? lastName,
  String? idCardNumber,
  String? phoneNumber,
  String? remark,
  DateTime? startDate,
  DateTime? endDate,
  String? cardDetail,
  DateTime? rentPaymentDate,
  String? rentPaymentSlip,
  double? rentPrice,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'create_date': createDate,
      'status': status,
      'vehicle_ref': vehicleRef,
      'first_name': firstName,
      'last_name': lastName,
      'id_card_number': idCardNumber,
      'phone_number': phoneNumber,
      'remark': remark,
      'start_date': startDate,
      'end_date': endDate,
      'card_detail': cardDetail,
      'rent_payment_date': rentPaymentDate,
      'rent_payment_slip': rentPaymentSlip,
      'rent_price': rentPrice,
    }.withoutNulls,
  );

  return firestoreData;
}

class RentListRecordDocumentEquality implements Equality<RentListRecord> {
  const RentListRecordDocumentEquality();

  @override
  bool equals(RentListRecord? e1, RentListRecord? e2) {
    return e1?.createDate == e2?.createDate &&
        e1?.status == e2?.status &&
        e1?.vehicleRef == e2?.vehicleRef &&
        e1?.firstName == e2?.firstName &&
        e1?.lastName == e2?.lastName &&
        e1?.idCardNumber == e2?.idCardNumber &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.remark == e2?.remark &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.cardDetail == e2?.cardDetail &&
        e1?.rentPaymentDate == e2?.rentPaymentDate &&
        e1?.rentPaymentSlip == e2?.rentPaymentSlip &&
        e1?.rentPrice == e2?.rentPrice;
  }

  @override
  int hash(RentListRecord? e) => const ListEquality().hash([
        e?.createDate,
        e?.status,
        e?.vehicleRef,
        e?.firstName,
        e?.lastName,
        e?.idCardNumber,
        e?.phoneNumber,
        e?.remark,
        e?.startDate,
        e?.endDate,
        e?.cardDetail,
        e?.rentPaymentDate,
        e?.rentPaymentSlip,
        e?.rentPrice
      ]);

  @override
  bool isValidKey(Object? o) => o is RentListRecord;
}
