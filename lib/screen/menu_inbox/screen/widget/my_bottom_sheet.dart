import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_widget.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detail Task',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.ac_unit,
                color: Colors.blue,
              ),
              const SizedBox(width: 10),
              Text(
                'Masyla Website Project',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'One of the website project in the field of digital services, located in california',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Icon(Icons.timer_sharp, color: Colors.red, size: 18),
                const SizedBox(width: 10),
                Text(
                  '08:30 PM',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.grey,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.access_alarm_sharp,
                              color: Colors.grey)),
                      Icon(
                        Icons.access_time_filled,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.flag,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 130,
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.density_medium_outlined,
                        color: Colors.grey,
                      ),
                    ))
              ],
            ),
          ),
          Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          TextField(
            maxLines: 3,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Tyiping ......',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    _showDialogTimeWorkDetail();
                  },
                  icon: Icon(
                    Icons.link,
                  )),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.send, color: Colors.blue))
            ],
          ),
          Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
        ],
      ),
    );
  }

  void _showDialogTimeWorkDetail() async {
    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogWidget();
        });
  }
}
