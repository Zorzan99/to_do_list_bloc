import 'package:firebase_auth/firebase_auth.dart';

abstract interface class LoginRepository {
  Future<User?> login(String email, String password);
}
