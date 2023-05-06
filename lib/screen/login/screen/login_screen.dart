import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/utils/app_constants.dart';

import '../../../repository/auth_repos.dart';
import '../../home/home_screen.dart';
import '../bloc/login_bloc.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppConstants.APPNAME,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: const Image(image: AssetImage('assets/logo.jpg'))),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CreateAccountScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider(
                                create: (context) => LoginBloc(),
                                child: EmailAddressScreen(),
                              )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Sign up',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Center(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            "Or continue with",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      AuthRepos().signInWithGoogle().then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen())));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/ic_google.png', width: 22),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
