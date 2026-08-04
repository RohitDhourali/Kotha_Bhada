import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';

class PropertyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SAVE PROPERTY
  // SAVE — takes RequestModel, no confusion
  Future<void> saveProperty(PropertyRequestModel property) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User must be logged in to save a property.');
    }

    final docRef = _firestore.collection('properties').doc();
    final propertyMap = property.toMap(user.uid);
    propertyMap['id'] = docRef.id;

    await docRef.set(propertyMap);
  }

  // DELETE — takes id from PropertyModel
  Future<void> deleteProperty(String propertyId) async {
    await _firestore.collection('properties').doc(propertyId).delete();
  }

  Future<List<PropertyModel>> fetchProperties() async {
    final snapshot = await _firestore.collection('properties').get();

    return snapshot.docs.map((doc) => PropertyModel.fromDocument(doc)).toList();
  }

  // FETCH — returns PropertyModel list
  Future<List<PropertyModel>> fetchMyProperties() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User must be logged in to fetch your properties.');
    }

    final snapshot = await _firestore
        .collection('properties')
        .where('userId', isEqualTo: user.uid)
        .get();
    return snapshot.docs.map((doc) => PropertyModel.fromDocument(doc)).toList();
  }
}
