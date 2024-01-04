import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

abstract interface class RegisterRepository {
  Future<User?> register(
    String email,
    String password,
    String displayName,
    Uint8List file,
  );
}
