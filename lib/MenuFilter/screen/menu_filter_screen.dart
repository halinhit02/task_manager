import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class MyMenuFilter extends StatefulWidget {
  const MyMenuFilter({Key? key}) : super(key: key);

  @override
  State<MyMenuFilter> createState() => _MyMenuFilterState();
}

class _MyMenuFilterState extends State<MyMenuFilter> {
  late DateTime selectedDay;

  void _hanleData(date) {
    setState(() {
      selectedDay = date;
    });
  }

  final Map<DateTime, List<CleanCalendarEvent>>? events = {DateTime.now(): []};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Schedule',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Calendar(
            startOnMonday: true,
            selectedColor: Colors.blueAccent,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {},
            onDateSelected: (date) {
              return _hanleData(date);
            },
            events: events,
            isExpanded: true,
            hideBottomBar: false,
            isExpandable: false,
            dayOfWeekStyle: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
            hideArrows: true,
            weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          ),
        ),
      ),
    );
  }
}
