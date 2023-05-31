import 'package:flutter/material.dart';
import 'package:thuc_tap_chuyen_nganh/helper/dialog_helper.dart';
import 'package:thuc_tap_chuyen_nganh/model/app_user.dart';
import 'package:thuc_tap_chuyen_nganh/repository/auth_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/task_list_screen.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/login_screen.dart';
import 'package:thuc_tap_chuyen_nganh/util/app_constants.dart';

import '../menu_filter/screen/menu_filter_screen.dart';
import '../menu_inbox/inbox_screen.dart';
import '../profile/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final pages = [
    const CreateTaskScreen(),
    const MenuInboxScreen(),
    const MyMenuFilter(),
    const MyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: pageIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: ''),
          ]),
    );
  }
}
