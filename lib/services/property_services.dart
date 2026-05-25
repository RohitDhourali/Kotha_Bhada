import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';

class PropertyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SAVE PROPERTY
  // SAVE — takes RequestModel, no confusion
  Future<String> saveProperty(PropertyRequestModel property) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = await _firestore
          .collection("properties")
          .add(property.toMap(uid)); // userId injected here
      await ref.update({"id": ref.id});
      return "Property saved successfully";
    } catch (e) {
      return "$e";
    }
  }

  // DELETE — takes id from PropertyModel
  Future<void> deleteProperty(String propertyId) async {
    await _firestore.collection('properties').doc(propertyId).delete();
  }

  Future<List<PropertyModel>> fetchProperties() async {
    final snapshot = await _firestore.collection("properties").get();

    return snapshot.docs.map((doc) => PropertyModel.fromDocument(doc)).toList();
  }

  // FETCH — returns PropertyModel list
  Future<List<PropertyModel>> fetchMyProperties() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await _firestore
        .collection("properties")
        .where("userId", isEqualTo: uid)
        .get();
    return snapshot.docs.map((doc) => PropertyModel.fromDocument(doc)).toList();
  }
}
