part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
}

class CheckEmailAddressEvent extends LoginEvent {
  bool isCheckEmailAddress;
  CheckEmailAddressEvent(this.isCheckEmailAddress);
}
