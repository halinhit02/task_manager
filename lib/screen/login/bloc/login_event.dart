part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
}

class CheckEmailAddressEvent extends LoginEvent {
  final String emailAddress;
  CheckEmailAddressEvent(this.emailAddress);
}

class UpdateUserNameEvent extends LoginEvent {
  String userName;
  UpdateUserNameEvent(this.userName);
}

class UpdateEmailEvent extends LoginEvent {
  String email;
  UpdateEmailEvent(this.email);
}

class UpdatePasswordEvent extends LoginEvent {
  String password;
  UpdatePasswordEvent(this.password);
}

class UpdateEmailSignInEvent extends LoginEvent {
  String email;
  UpdateEmailSignInEvent(this.email);
}

class UpdatePasswordSignInEvent extends LoginEvent {
  String password;
  UpdatePasswordSignInEvent(this.password);
}

class CheckValidaEvent extends LoginEvent {}

class CreateNewAccount extends LoginEvent {}

class CheckValidaEventSignIn extends LoginEvent {}
