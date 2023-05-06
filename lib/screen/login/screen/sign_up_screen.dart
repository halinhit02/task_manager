import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/utils/app_constants.dart';

import '../../../repository/auth_repos.dart';
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

  // TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is CheckEmailAddressState) {
          checkEmailAddress = state.checkEmailAddress;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                          height: 60,
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
                          height: 40,
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
                                labelText: 'Enter your name',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
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
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter your email',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
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
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<LoginBloc>()
                                  .add(CheckEmailAddressEvent(value));
                            },
                            obscureText: true,
                            decoration: InputDecoration(
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
                  TextButton(
                      onPressed: () {
                        if (checkEmailAddress) {}
                        AuthRepos()
                            .signUp('admin', 'email@gmail.com', 'password')
                            .then((value) => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (_) => const HomeScreen())));
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: checkEmailAddress
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
