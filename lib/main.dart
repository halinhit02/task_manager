import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lib/Login/bloc/login_bloc.dart';
import 'lib/Login/screen/Introduce.dart';

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
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const MyLogin(),
        ));
  }
}
