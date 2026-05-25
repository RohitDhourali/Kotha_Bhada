// controller/auth_controller
import 'package:flutter_application_1/repository/auth_repository.dart';
import '../models/users.dart';

class AuthController {
  final AuthRepository _repository = AuthRepository();


  Future<String> signUp(String email, String password, String username) async {
    Users use = Users(username: username, email: email, password: password);

   try{

  await _repository.signUp(use);
    
      return "1";
    
    
  } catch (e) {
    return e.toString();
  }
  }

Future<String> loginUser(
    String email,
    String password,
) async {
try{
  await _repository.loginUser(
    email,
    password,
  );

  
    return "1";
  
}
catch (e) {
  return e.toString();
}
  }
}