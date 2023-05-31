import 'package:flutter/material.dart';
import 'package:thuc_tap_chuyen_nganh/repository/auth_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/home/home_screen.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/login_screen.dart';

import '../../util/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var result = await AuthRepos.instance().isAuthenticated();
    if (result) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        ),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        ),
      );
    }
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
            const Text(
              'The best to do list application for you',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
