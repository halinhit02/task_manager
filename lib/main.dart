import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/bloc/login_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/introduce_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const IntroduceScreen(),
        ));
  }
}
