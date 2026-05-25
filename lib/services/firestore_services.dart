import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SAVE NAME
  Future<void> saveName(String name) async {
    await _firestore.collection("users").add({
      "name": name,
    });
  }

  // FETCH NAME
  Future<String> fetchName() async {
    QuerySnapshot snapshot =
        await _firestore.collection("users").get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first["name"];
    } else {
      return "No Name Found";
    }
  }
}