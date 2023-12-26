import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:to_do_list_bloc/pages/login/login_state.dart';
import 'package:to_do_list_bloc/repositories/login/login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginCubit(this._loginRepository) : super(InitialLogin());

  Future<void> login(String email, String password) async {
    emit(LoadingLogin());

    await Future.delayed(
        const Duration(seconds: 2)); // Simula um carregamento de 2 segundos

    try {
      await _loginRepository.login(email, password);
      emit(LoadedLogin());
    } catch (e, s) {
      log('Erro Cubit login', error: e, stackTrace: s);
      emit(FailureLogin(message: 'Erro ao realizar login'));
    }
  }
}
