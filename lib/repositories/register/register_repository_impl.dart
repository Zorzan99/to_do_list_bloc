import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RegisterRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(
      String email, String password, String displayName, Uint8List file) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      String imageUrl = await uploadImageToStorage('profileImage', file);

      await userCredential.user?.updateDisplayName(displayName);
      await _firestore.collection('userProfile').add({
        'imageLink': imageUrl,
      });

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

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
