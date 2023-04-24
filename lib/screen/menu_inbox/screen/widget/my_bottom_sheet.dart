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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Detail Task',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                        width: 2,
                        color: Colors.teal,
                      )),
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      )),
                  child: const Icon(
                    Icons.circle_rounded,
                    color: Colors.teal,
                    size: 8,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Masyla Website Project',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'One of the website project in the field of digital services, located in california',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer_sharp, color: Colors.red, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            '08:30 PM',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: Colors.grey,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.access_alarm_sharp,
                                  color: Colors.grey)),
                          Icon(
                            Icons.flag,
                            color: Colors.grey,
                          ),
                          const Expanded(child: const SizedBox()),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.menu_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: 'Tyiping ......',
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _showDialogTimeWorkDetail();
                    },
                    icon: const Icon(
                      Icons.link,
                    )),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 20,
                    ))
              ],
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
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
