sealed class RegisterState {}

class InitialRegister implements RegisterState {}

class LoadingRegister implements RegisterState {}

class LoadedRegister implements RegisterState {}

class FailureRegister implements RegisterState {
  final String message;
  FailureRegister({required this.message});
}
