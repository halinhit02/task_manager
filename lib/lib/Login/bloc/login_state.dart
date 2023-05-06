part of 'login_bloc.dart';

class LoginState {
  const LoginState();
}

class LoginInitState extends LoginState {}

class CheckEmailAddressState extends LoginState {
  final bool checkEmailAddress;
  const CheckEmailAddressState(this.checkEmailAddress);
}
