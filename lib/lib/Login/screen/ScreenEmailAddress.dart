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
  bool checkEmailAddress = false;
  String alo = '';
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
          if (state is CheckEmailAddressState) {
            checkEmailAddress = state.checkEmailAddress;
          }
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: Text(
                    "Welcome Back!",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Your work faster and structured with Task Manager',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Email Address",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) {
                      alo = value;
                      // context.read<LoginBloc>().add(
                      //     CheckEmailAddressEvent(checkEmailAddress, value));
                      setState(() {
                        if (value.isNotEmpty) {
                          checkEmailAddress = true;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: 'name@example.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ],
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 18),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CreateAccount()));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(160, 15, 160, 15),
                    decoration: BoxDecoration(
                        color:
                            checkEmailAddress ? Colors.blueAccent : Colors.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white,),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
