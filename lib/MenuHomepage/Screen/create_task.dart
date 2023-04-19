import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_homepage_bloc.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuHomepageBloc(),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  TimeOfDay time = const TimeOfDay(hour: 07, minute: 00);
  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuHomepageBloc, MenuHomepageState>(
      listener: (context, state) => {},
      child: BlocBuilder<MenuHomepageBloc, MenuHomepageState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Today',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Best platform for creating to-do lists',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Tap plus to create a new task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Add your task',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Today, Mon 20 Jul 2022',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: Column(
                    children: [
                      Container(
                        height: 40,
                        color: Colors.teal,
                        child: ListTile(
                          leading: Icon(
                            Icons.ac_unit_sharp,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Priority task 1',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            '...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Masyla Website Project',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Add your task',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Today, Mon 20 Jul 2022',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: Column(
                    children: [
                      Container(
                        height: 40,
                        color: Colors.redAccent,
                        child: ListTile(
                          leading: Icon(
                            Icons.ac_unit_sharp,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Priority task 3',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            '...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Masyla Website Project',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Add your task',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Today, Mon 20 Jul 2022',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showBottomSheet();
              },
              backgroundColor: Colors.teal,
              child: Icon(
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
          return Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      autofocus: true,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
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
                        const SizedBox(
                          width: 200,
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
