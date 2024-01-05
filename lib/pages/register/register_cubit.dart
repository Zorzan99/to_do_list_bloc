import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:to_do_list_bloc/pages/register/register_state.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  bool isPasswordVisible = false;

  final RegisterRepository _registerRepository;
  RegisterCubit(this._registerRepository) : super(InitialRegister());

  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    emit(LoadingRegister());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _registerRepository.register(email, password, displayName);
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
}
