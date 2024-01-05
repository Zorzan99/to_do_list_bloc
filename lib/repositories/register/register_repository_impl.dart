import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import './register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseAuth _firebaseAuth;

  RegisterRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(
      String email, String password, String displayName) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCredential.user?.updateDisplayName(displayName);

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Erro', error: e, stackTrace: s);

      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw Exception(
              'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          throw Exception(
              'Você se cadastrou no TodoList pelo Google, por favor utilize ele para efetuar o login');
        }
      } else {
        throw Exception(e.message ?? 'Erro ao registrar usuário');
      }
    }
  }
}
