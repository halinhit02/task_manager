import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repos.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late bool check;
  late String userName;
  late String email;
  late String password;
  late String emailSignIn;
  late String passwordSignIn;
  LoginBloc() : super(LoginInitState()) {
    check = false;
    userName = '';
    email = '';
    password = '';
    emailSignIn = '';
    passwordSignIn = '';
    on<CheckEmailAddressEvent>(_onCheckEmailAddress);
    on<UpdateUserNameEvent>(_onUpdateUserName);
    on<UpdateEmailEvent>(_onUpdateEmail);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<CheckValidaEvent>(_onCheckValidaEvent);
    on<UpdateEmailSignInEvent>(_onUpdateEmailSignIn);
    on<UpdatePasswordSignInEvent>(_onUpdatePasswordSignIn);
    on<CheckValidaEventSignIn>(_onCheckValidaEventSignIn);
  }

  void _onCheckEmailAddress(CheckEmailAddressEvent event, Emitter emit) async {
    if (event.emailAddress.isNotEmpty) {
      check = true;
    } else {
      check = false;
    }
    emit(CheckEmailAddressState(check));
  }

  void _onUpdateUserName(UpdateUserNameEvent event, Emitter<LoginState> emit) {
    userName = event.userName;
  }

  void _onUpdateEmail(UpdateEmailEvent event, Emitter<LoginState> emit) {
    email = event.email;
  }

  void _onUpdatePassword(UpdatePasswordEvent event, Emitter<LoginState> emit) {
    password = event.password;
  }

  void _onUpdateEmailSignIn(
      UpdateEmailSignInEvent event, Emitter<LoginState> emit) {
    emailSignIn = event.email;
  }

  void _onUpdatePasswordSignIn(
      UpdatePasswordSignInEvent event, Emitter<LoginState> emit) {
    passwordSignIn = event.password;
  }

  void _onCheckValidaEvent(CheckValidaEvent event, Emitter<LoginState> emit) {
    bool isValidate = true;
    if (userName == '') {
      emit(ValidateUserNameState());
      isValidate = false;
    }
    if (email == '') {
      emit(ValidateEmailState());
      isValidate = false;
    }
    if (password == '') {
      emit(ValidatePasswordState());
      isValidate = false;
    }
    if (isValidate == false) {
      return;
    }
    emit(
      state.copyWith(showDialogConfirm: true),
    );
  }

  void _onCheckValidaEventSignIn(
      CheckValidaEventSignIn event, Emitter<LoginState> emit) {
    bool isValidate = true;
    if (emailSignIn == '') {
      emit(ValidateEmailSignInState());
      isValidate = false;
    }
    if (passwordSignIn == '') {
      emit(ValidatePasswordSignInState());
      isValidate = false;
    }
    if (isValidate == false) {
      return;
    }
    emit(
      state.copyWith(showDialogConfirmSignIn: true),
    );
  }
}
