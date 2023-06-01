import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/model/task_type.dart';
import 'package:thuc_tap_chuyen_nganh/repository/database_repos.dart';

import '../../../../helper/dialog_helper.dart';
import '../../../../model/app_user.dart';
import 'my_chart.dart';

class MyProductivity extends StatefulWidget {
  const MyProductivity({Key? key}) : super(key: key);

  @override
  State<MyProductivity> createState() => _MyProductivityState();
}

class _MyProductivityState extends State<MyProductivity> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        title: const Text(
          'Productivity',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<AppUser?>(
            future: DatabaseRepo.instance.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: snapshot.data!.photoURL.isEmpty
                              ? Image.asset(
                                  'assets/avatar.png',
                                  width: 84,
                                  height: 84,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  snapshot.data!.photoURL,
                                  width: 84,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data?.username ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data?.email ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  var dt = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate:
                                        selectedDate.copyWith(month: 1, day: 1),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1, 0, 0),
                                  );
                                  if (dt != null) {
                                    selectedDate = dt;
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(DateFormat(
                                            DateFormat.YEAR_NUM_MONTH_DAY,
                                            'vi-vn')
                                        .format(selectedDate)),
                                  ],
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                              width: 1,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.insert_chart,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('My Report'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Report Progress',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: FutureBuilder<List<Task>>(
                            future: DatabaseRepo.instance.getTasksByDate(
                                selectedDate.millisecondsSinceEpoch),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    snapshot.error.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }
                              var finishTaskCount = snapshot.data
                                  ?.where((element) =>
                                      element.type == TaskType.Finished ||
                                      element.type == TaskType.Canceled)
                                  .length;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Set a goal',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$finishTaskCount/${snapshot.data!.length}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Task',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    'Finish your task now!',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Statistic Goals',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 300,
                                    child: MyChart(
                                      chartDatas: [
                                        ChartData('Feb', 17, 0, 0, 0),
                                        ChartData('Mar', 38, 0, 0, 0),
                                        ChartData('Apr', 37, 0, 0, 0),
                                        ChartData('May', 35, 0, 0, 0),
                                        ChartData(
                                            'Jun',
                                            (finishTaskCount! /
                                                    snapshot.data!.length *
                                                    100)
                                                .round(),
                                            0,
                                            0,
                                            0)
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
