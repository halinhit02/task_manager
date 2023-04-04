part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
}

class CheckEmailAddressEvent extends LoginEvent {
  final String emailAddress;
  CheckEmailAddressEvent(this.emailAddress);
}
