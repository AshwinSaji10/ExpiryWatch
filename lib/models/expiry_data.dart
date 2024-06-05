import 'package:cloud_firestore/cloud_firestore.dart';

class ExpiryData {
  int? uuid;
  String? itemName;
  DateTime? expiryDate;

  ExpiryData({this.uuid, this.itemName, this.expiryDate});

  static ExpiryData fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ExpiryData(
        uuid: snapshot['uuid'] as int,
        itemName: snapshot['itemname'] as String?,
        expiryDate: (snapshot['expirydate'] as Timestamp?)?.toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "itemname": itemName,
      "expirydate": expiryDate,
    };
  }
}
