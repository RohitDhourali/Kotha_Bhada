import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;        // required, always present ✅
  final String userId;
  final String flatType;
  final String rent;
  final String address;
  final String description;
  final String ownername;
  final String ownercontact;

  PropertyModel({
    required this.id,
    required this.userId,
    required this.flatType,
    required this.rent,
    required this.address,
    required this.description,
    required this.ownername,
    required this.ownercontact,
  });
factory PropertyModel.fromDocument(DocumentSnapshot doc) {
  final map = doc.data() as Map<String, dynamic>;
  return PropertyModel(
    id: doc.id,
    userId: map['userId']?.toString() ?? '',
    flatType: map['flatType']?.toString() ?? '',
    rent: map['rent']?.toString() ?? '',        // ← toString() handles int/double
    address: map['address']?.toString() ?? '',
    description: map['description']?.toString() ?? '',
    ownername: map['ownername']?.toString() ?? '',
    ownercontact: map['ownercontact']?.toString() ?? '',
  );
}
}