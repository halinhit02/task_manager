import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Login/screen/Introduce.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _zoomInOutAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _zoomInOutAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 50, end: 120),
        weight: 2,
      ),
      TweenSequenceItem(tween: Tween<double>(begin: 120, end: 100), weight: 1)
    ]).animate(_controller);
    _controller.forward().whenComplete(() => const MyLogin());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _zoomInOutAnimation,
      builder: (context, widget) => Scaffold(
        body: Center(
          child: Image.asset(
            'assets/logo.jpg',
            height: _zoomInOutAnimation.value,
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 20, left: 18),
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MyLogin()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(160, 15, 160, 15),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        ),
      ),
    );
  }
}
