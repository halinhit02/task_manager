import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/login_screen.dart';

import '../../util/app_constants.dart';
import '../login/bloc/login_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginScreen(),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/ic_app.png',
                  height: 64,
                  width: 64,
                )),
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 18),
              child: Text(
                AppConstants.APPNAME,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Text(
              'The best to do list application for you',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
