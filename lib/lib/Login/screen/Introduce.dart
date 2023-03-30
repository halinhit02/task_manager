import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import 'ScreenWelcome.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    trailing: Text(
                      "Skip",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image(image: AssetImage('assets/logo.jpg')),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Your Convenience in making a todo List",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Here's a mobile platform that hepls you create task or to list so that it can help you in every job easier and faster.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (context) => LoginBloc(),
                                  child: Welcome(),
                                )));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            ),
          );
        }));
  }
}
