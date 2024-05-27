import 'package:cloud_firestore/cloud_firestore.dart';

class ExpiryData {
  String? itemName;
  DateTime? expiryDate;

  ExpiryData({this.itemName, this.expiryDate});

  static ExpiryData fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ExpiryData(
        itemName: snapshot['itemname'] as String?,
        expiryDate: (snapshot['expirydate'] as Timestamp?)?.toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      "itemname": itemName,
      "expirydate": expiryDate,
    };
  }
}
