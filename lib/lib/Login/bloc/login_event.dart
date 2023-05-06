part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
}

class CheckEmailAddressEvent extends LoginEvent {
  final String emailAddress;
  bool isCheckEmailAddress;
  CheckEmailAddressEvent(this.isCheckEmailAddress, this.emailAddress);
}
