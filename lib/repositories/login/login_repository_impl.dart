import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import './login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseAuth _firebaseAuth;
  LoginRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e, s) {
      log("Error LoginRepositoryImpl ", error: e, stackTrace: s);
    }
    throw Exception("Erro ao realizar login");
  }
}
