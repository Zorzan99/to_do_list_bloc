import 'package:firebase_auth/firebase_auth.dart';

abstract interface class RegisterRepository {
  Future<User?> register(String email, String password, String displayNam);
}
