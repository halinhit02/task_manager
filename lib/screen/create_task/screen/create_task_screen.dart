import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/helper/date_time_helper.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/repository/database_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/screen/widget/item_task.dart';
import 'package:intl/intl.dart';

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
  late List<Task> listTask;

  @override
  void initState() {
    super.initState();
    listTask = [];
    _onGetListTask();
  }

  void _onGetListTask() {
    context.read<MenuHomepageBloc>().add(GetListTaskEvent());
  }

  void _handleListener(BuildContext context, MenuHomepageState state) {
    if (state is TimeState) {
      time = state.time;
    }
    if (state is GetListTaskSuccessState) {
      listTask = state.listTask;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuHomepageBloc, MenuHomepageState>(
      listener: (context, state) => _handleListener(context, state),
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
                  InkWell(
                    onTap: () => showCreateTaskSheet(),
                    child: Column(
                      children: [
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
                                            'Tap plus to create a new task',
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
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'Add your task',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) =>
                        ItemTask(onClickEdit: showCreateTaskSheet),
                  )),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showCreateTaskSheet();
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

  void showCreateTaskSheet() {
    TextEditingController titleTextEditing = TextEditingController();
    TextEditingController descriptionTextEditing = TextEditingController();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 2 / 3,
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: titleTextEditing,
                  decoration: InputDecoration(
                    hintText: 'Eg: Metting with client.',
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    context.read<MenuHomepageBloc>().add(TitleEvent(value));
                  },
                ),
                TextField(
                  autofocus: true,
                  controller: descriptionTextEditing,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    context
                        .read<MenuHomepageBloc>()
                        .add(DescriptionEvent(value));
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    _showDateTimeSheet((time) {});
                  },
                  padding: EdgeInsets.zero,
                  child: const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('07:40 39/12/2023'),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {
                    DatabaseRepo()
                        .setTask(Task(
                            id: DateTimeHelper.getCurrentTimeMillis()
                                .toString(),
                            title: titleTextEditing.text,
                            description: descriptionTextEditing.text,
                            time: DateTimeHelper.getCurrentTimeMillis()))
                        .then((value) => Navigator.of(context).pop())
                        .catchError((e) => print(e));
                  },
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    10,
                  )),
                  child: const SizedBox(
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        'Create task',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showDateTimeSheet(Function(DateTime) onTimeAdded) {
    TextEditingController currentDate = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          DateTime pickedDateTime = DateTime.now();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Set Time',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        initialDate: pickedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1, -1),
                      ).then((value) => setState(() {
                            pickedDateTime = value ?? DateTime.now();
                            currentDate.text =
                                DateFormat('yyyy-MM-dd').format(value!);
                            context
                                .read<MenuHomepageBloc>()
                                .add(DateEvent(value));
                          }));
                    },
                    leading: const Icon(Icons.sunny),
                    title: const Text(
                      'Date',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Text('${currentDate.text}'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () async {
                      var newTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: pickedDateTime.hour,
                            minute: pickedDateTime.minute,
                          ));
                      if (newTime != null) {
                        context
                            .read<MenuHomepageBloc>()
                            .add(TimeEvent(newTime));
                        pickedDateTime = pickedDateTime.copyWith(
                            hour: newTime.hour, minute: newTime.minute);
                      }
                    },
                    leading: const Icon(Icons.timer),
                    title: const Text(
                      'Time',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing:
                        Text('${pickedDateTime.hour}:${pickedDateTime.minute}'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      onTimeAdded.call(pickedDateTime);
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.timer_sharp,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Schedule',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
