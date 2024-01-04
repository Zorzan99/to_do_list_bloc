import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list_bloc/pages/register/register_state.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  bool isPasswordVisible = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RegisterRepository _registerRepository;
  RegisterCubit(this._registerRepository) : super(InitialRegister());

  Future<void> register(
      String email, String password, String displayName, Uint8List file) async {
    emit(LoadingRegister());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _registerRepository.register(email, password, displayName, file);
      emit(LoadedRegister());
    } catch (e, s) {
      log('Erro Cubit register', error: e, stackTrace: s);
      emit(FailureRegister(message: 'Erro ao realizar login'));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(HidePasswordRegister(visible: isPasswordVisible));
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      Uint8List? imageBytes = await file.readAsBytes();

      return imageBytes;
    }
    return null;
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> saveData({
    required Uint8List file,
  }) async {
    String resp = " Some error ocurred ";
    try {
      String imageUrl = await uploadImageToStorage('profileImage', file);
      await _firestore.collection('userProfile').add({
        'imageLink': imageUrl,
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
