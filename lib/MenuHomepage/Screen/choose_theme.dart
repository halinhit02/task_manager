import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bottomNavigatorBar_screen/bottom_navigator_screen.dart';

class MyMenuHomepage extends StatelessWidget {
  const MyMenuHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Create to do list',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Choose your to do list color theme',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Column(
                children: [
                  Container(
                    height: 30,
                    color: Colors.teal,
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 70,
                        width: 70,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          skelton(
                            width: 160,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          skelton(
                            height: 20,
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Column(
                children: [
                  Container(
                    height: 30,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 70,
                        width: 70,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          skelton(
                            width: 160,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          skelton(
                            height: 20,
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Column(
                children: [
                  Container(
                    height: 30,
                    color: Colors.red,
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 70,
                        width: 70,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          skelton(
                            width: 160,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          skelton(
                            height: 20,
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Column(
                children: [
                  Container(
                    height: 30,
                    color: Colors.blueAccent,
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 70,
                        width: 70,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          skelton(
                            width: 160,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          skelton(
                            height: 20,
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20, left: 18),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BottomNavigatorBarScreen()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                'Open Todoapp',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
      ),
    );
  }
}

class skelton extends StatelessWidget {
  const skelton({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.09),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}
