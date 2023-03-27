import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState()) {
    on<CheckEmailAddressEvent>(_onCheckEmailAddress);
  }

  void _onCheckEmailAddress(CheckEmailAddressEvent event, Emitter emit) async {
    // if (event.emailAddress.length > 0) {
    event.isCheckEmailAddress = true;
    // }
    emit(true);
  }
}
