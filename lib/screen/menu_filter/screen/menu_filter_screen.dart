import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

import '../../create_task/screen/widget/item_task.dart';

class MyMenuFilter extends StatefulWidget {
  const MyMenuFilter({Key? key}) : super(key: key);

  @override
  State<MyMenuFilter> createState() => _MyMenuFilterState();
}

class _MyMenuFilterState extends State<MyMenuFilter> {
  late DateTime selectedDay;

  void _handleData(date) {
    setState(() {
      selectedDay = date;
    });
  }

  final Map<DateTime, List<CleanCalendarEvent>>? events = {DateTime.now(): []};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Schedule',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                },
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, index) => SizedBox() //ItemTask(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
