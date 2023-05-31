import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/menu_inbox/screen/widget/my_task_detail_sheet.dart';

import '../../../helper/date_time_helper.dart';
import '../../../model/task.dart';
import '../../../repository/database_repos.dart';
import '../../create_task/widget/create_task_sheet.dart';
import '../../create_task/widget/item_task.dart';
import '../bloc/menu_inbox_bloc.dart';
import 'package:intl/intl.dart';

class MenuInboxScreen extends StatelessWidget {
  const MenuInboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuInboxBloc(),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late List<Task> listComment;
  final DatabaseRepo _databaseRepo = DatabaseRepo.instance;

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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: FutureBuilder<List<Task>>(
            future: _databaseRepo.getTasksByDate(
              DateTime.now().millisecondsSinceEpoch,
            ),
            builder: (_, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('There are no data.'),
                );
              }
              var taskList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () => _showTaskDetailSheet(taskList[index]),
                  child: ItemTask(
                    task: taskList[index],
                    onClickEdit: () => showEditTaskSheet(taskList[index]),
                    index: index,
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _showTaskDetailSheet(Task task) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return MyTaskDetailSheet(
            task: task,
          );
        });
  }

  Future showEditTaskSheet(Task currentTask) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 2 / 3,
        ),
        builder: (BuildContext context) => CreateTaskSheet(
              currentTask: currentTask,
              isEdit: true,
            ));
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
                            context.read<MenuInboxBloc>().add(DateEvent(value));
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
                        context.read<MenuInboxBloc>().add(TimeEvent(newTime));
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
