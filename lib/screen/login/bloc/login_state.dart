part of 'login_bloc.dart';

class LoginState {
  final String userName;
  final String email;
  final String password;
  final bool showDialogConfirm;
  final bool showDialogConfirmSignIn;

  LoginState(
      {this.userName = '',
      this.email = '',
      this.password = '',
      this.showDialogConfirm = false,
      this.showDialogConfirmSignIn = false});

  LoginState copyWith(
      {String? userName,
      String? email,
      String? password,
      bool? showDialogConfirm,
      bool? showDialogConfirmSignIn}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        userName: userName ?? this.userName,
        showDialogConfirm: showDialogConfirm ?? this.showDialogConfirm,
        showDialogConfirmSignIn:
            showDialogConfirmSignIn ?? this.showDialogConfirmSignIn);
  }
}

class LoginInitState extends LoginState {}

class CheckEmailAddressState extends LoginState {
  final bool checkEmailAddress;
  CheckEmailAddressState(this.checkEmailAddress);
}

class CreateNewAccountSuccess extends LoginState {}

class ValidateUserNameState extends LoginState {}

class ValidateEmailState extends LoginState {}

class ValidatePasswordState extends LoginState {}

class ValidateEmailSignInState extends LoginState {}

class ValidatePasswordSignInState extends LoginState {}
