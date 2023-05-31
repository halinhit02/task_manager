import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/bloc/login_bloc.dart';

import '../../../helper/dialog_helper.dart';
import '../../../repository/auth_repos.dart';
import '../../../repository/database_repos.dart';
import '../../../util/app_constants.dart';
import '../../home/home_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String email = '';
  String password = '';
  String? errorEmail;
  String? errorPassword;

  void _onSignIn() {
    DialogHelper.showLoadingDialog(context);
    AuthRepos().signInWithEmailPassword(email, password).then((value) {
      if (value != null) {
        DatabaseRepo.instance.setUserInfo(value).then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        }).catchError((e) {
          Navigator.of(context).pop();
          DialogHelper.showSnackBar(context, e.toString(), isError: true);
        });
      }
    }).catchError((e) {
      Navigator.of(context).pop();
      DialogHelper.showSnackBar(context, e.toString(), isError: true);
    });
  }

  void _hanldeListener(BuildContext context, LoginState state) {
    if (state is ValidateEmailSignInState) {
      errorEmail = 'Không để trống trường này';
    }
    if (state is ValidatePasswordSignInState) {
      errorPassword = 'Không để trống trường này';
    }
    if (state.showDialogConfirmSignIn) {
      _onSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) => _hanldeListener(context, state),
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Text(
                            "Welcome Back!",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Your work faster and structured with ${AppConstants.APPNAME}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter your email',
                                errorText:
                                    state.email.isNotEmpty ? null : errorEmail,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                            onChanged: (value) {
                              email = value;
                              context
                                  .read<LoginBloc>()
                                  .add(UpdateEmailSignInEvent(value));
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: state.password.isNotEmpty
                                  ? null
                                  : errorPassword,
                              labelText: 'Enter your password',
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onChanged: (value) {
                              password = value;
                              context
                                  .read<LoginBloc>()
                                  .add(UpdatePasswordSignInEvent(value));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(CheckValidaEventSignIn());
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
