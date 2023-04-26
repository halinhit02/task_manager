import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/bloc/login_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/login_screen.dart';
import 'package:thuc_tap_chuyen_nganh/screen/splash/splash_screen.dart';

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
          primaryColor: const Color(0xff17A1A1),
          primarySwatch: Colors.teal,
        ),
        home: BlocProvider(
          create: (context) => LoginBloc(),
          child: const SplashScreen(),
        ));
  }
}
