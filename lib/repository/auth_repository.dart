import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users.dart';

class AuthRepository {
  final FirebaseAuthService _service = FirebaseAuthService();

  Future<User?> signUp(Users user) async {
    try{
      return await _service.signUp(user);
    } catch (e) {
     throw e.toString();
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try{
      return await _service.login(
        Users(email: email, password: password, username: ""),
      );
    } catch (e) {
      throw e.toString();
    }
  }

 
}
