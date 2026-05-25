// services/firebase_auth_service.dart
import '../models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(Users user) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      return result.user;
    }
       on FirebaseAuthException catch (e) {

    throw e.message ?? "Signup failed";
  }
     
     
    }
  

  Future<User?> login(Users user) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      return result.user;
    }  on FirebaseAuthException catch (e) {

    throw e.message ?? "Login failed";
  }
     
    }
  }



