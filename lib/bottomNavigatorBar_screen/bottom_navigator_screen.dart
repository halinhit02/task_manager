import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MenuFilter/screen/menu_filter_screen.dart';
import '../MenuHomepage/Screen/create_task.dart';
import '../MenuInbox/screen/inbox_screen.dart';
import '../profile/screen/profile_screen.dart';

class BottomNavigatorBarScreen extends StatefulWidget {
  const BottomNavigatorBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorBarScreen> createState() =>
      _BottomNavigatorBarScreenState();
}

class _BottomNavigatorBarScreenState extends State<BottomNavigatorBarScreen> {
  int pageIndex = 0;
  final pages = [
    const CreateTask(),
    const MyInboxScreen(),
    const MyMenuFilter(),
    const MyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_filled,
                      color: Colors.teal,
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.work_rounded,
                      color: Colors.teal,
                      size: 35,
                    )
                  : const Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.widgets_rounded,
                      color: Colors.teal,
                      size: 35,
                    )
                  : const Icon(
                      Icons.widgets_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 35,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
