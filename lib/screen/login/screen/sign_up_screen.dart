import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/dialog_helper.dart';
import '../../../repository/auth_repos.dart';
import '../../../repository/database_repos.dart';
import '../../../util/app_constants.dart';
import '../../home/home_screen.dart';
import '../bloc/login_bloc.dart';

class EmailAddressScreen extends StatelessWidget {
  const EmailAddressScreen({Key? key}) : super(key: key);

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
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  bool checkEmailAddress = false;
  String userName = '';
  String email = '';
  String password = '';
  String? errorUserName;
  String? errorEmail;
  String? errorPassword;

  void _singUp() {
    DialogHelper.showLoadingDialog(context);
    AuthRepos().signUp(userName, email, password).then((value) {
      if (value != null) {
        DatabaseRepo.instance.setUserInfo(value).then((value) {
          Navigator.pop(context);
          DialogHelper.showSnackBar(context, 'Tài khoản đã được tạo.');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
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
    if (state is CheckEmailAddressState) {
      checkEmailAddress = state.checkEmailAddress;
    }
    if (state is ValidateUserNameState) {
      errorUserName = 'Không để trống trường này';
    }
    if (state is ValidateEmailState) {
      errorEmail = 'Không để trống trường này';
    }
    if (state is ValidatePasswordState) {
      errorPassword = 'Không để trống trường này';
    }
    if (state.showDialogConfirm) {
      _singUp();
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
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            "Create New Account",
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
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "UserName",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                                errorText: state.userName.isNotEmpty
                                    ? null
                                    : errorUserName,
                                labelText: 'Enter your name',
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                            onChanged: (value) {
                              userName = value;
                              context
                                  .read<LoginBloc>()
                                  .add(UpdateUserNameEvent(value));
                            },
                          ),
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                errorText:
                                    state.email.isNotEmpty ? null : errorEmail,
                                labelText: 'Enter your email',
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
                                  .add(UpdateEmailEvent(value));
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
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            onChanged: (value) {
                              password = value;
                              context
                                  .read<LoginBloc>()
                                  .add(UpdatePasswordEvent(value));
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: state.password.isNotEmpty
                                  ? null
                                  : errorPassword,
                              labelText: 'Enter your password',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: TextButton(
                onPressed: () {
                  context.read<LoginBloc>().add(CheckValidaEvent());
                },
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )),
          );
        });
  }
}
