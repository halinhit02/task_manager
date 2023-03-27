import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import 'ScreenCreateAccount.dart';

class MyEmailAddress extends StatefulWidget {
  const MyEmailAddress({Key? key}) : super(key: key);

  @override
  State<MyEmailAddress> createState() => _MyEmailAddressState();
}

class _MyEmailAddressState extends State<MyEmailAddress> {
  // bool checkEmailAddress = false;
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
          //checkEmailAddress = state.checkEmailAddress;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      "Welcome Back!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Your work faster and structured with Todyapp',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Email Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      //controller: _controller,
                      onChanged: (value) {
                        // context
                        //     .read<LoginBloc>()
                        //     .add(CheckEmailAddressEvent(checkEmailAddress));
                      },
                      decoration: InputDecoration(
                          labelText: 'name@example.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.only(bottom: 20, left: 18),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount()));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(160, 15, 160, 15),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
