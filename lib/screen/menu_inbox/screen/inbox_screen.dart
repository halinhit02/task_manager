import 'package:flutter/material.dart';
import 'package:thuc_tap_chuyen_nganh/screen/menu_inbox/screen/widget/my_bottom_sheet.dart';

import '../../create_task/screen/widget/item_task.dart';

class MenuInboxScreen extends StatefulWidget {
  const MenuInboxScreen({Key? key}) : super(key: key);

  @override
  State<MenuInboxScreen> createState() => _MenuInboxScreenState();
}

class _MenuInboxScreenState extends State<MenuInboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Inbox',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) => InkWell(
          onTap: () => _showBottomSheep(),
          child: ItemTask(),
        ),
      ),
    );
  }

  void _showBottomSheep() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const MyBottomSheet();
        });
  }
}
