import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/screen/widget/item_task.dart';

import '../bloc/menu_homepage_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuHomepageBloc(),
      child: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TimeOfDay time = const TimeOfDay(hour: 07, minute: 00);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuHomepageBloc, MenuHomepageState>(
      listener: (context, state) => {},
      child: BlocBuilder<MenuHomepageBloc, MenuHomepageState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Today',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'Best platform for creating to-do lists',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        )),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Masyla Website Project',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.6,
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Add your task',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Today, Mon 20 Jul 2022',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) => ItemTask(),
                  )),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showBottomSheet();
              },
              backgroundColor: Colors.teal,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Eg: Metting with client.',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.grey,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _showBottomSheep1();
                                      },
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
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              ))
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        endIndent: 10,
                        indent: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showBottomSheep1() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          TimeOfDay time = const TimeOfDay(hour: 07, minute: 00);
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(Icons.sunny),
                    title: Text(
                      'Today',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Text('4 Apr 2022'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud_outlined),
                    title: Text(
                      'Tomorrow',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Text('Sat'),
                  ),
                  ListTile(
                    leading: Icon(Icons.time_to_leave_outlined),
                    title: Text(
                      'Time',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Text('8:20'),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Future<TimeOfDay?> newTime = showTimePicker(
                              context: context, initialTime: time);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.teal,
                              ),
                              Text(
                                'Add Time',
                                style: TextStyle(color: Colors.teal),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.all(15),
                          // decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10))),
                          color: Colors.teal,
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                color: Colors.white,
                              ),
                              Text(
                                'Reschedule',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
