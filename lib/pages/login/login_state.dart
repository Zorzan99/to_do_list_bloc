sealed class LoginState {}

class InitialLogin implements LoginState {}

class LoadingLogin implements LoginState {}

class LoadedLogin implements LoginState {}

class FailureLogin implements LoginState {
  final String message;
  FailureLogin({required this.message});
}
