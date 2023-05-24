import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/menu_inbox/screen/widget/my_bottom_sheet.dart';

import '../../../helper/date_time_helper.dart';
import '../../../model/task.dart';
import '../../../repository/database_repos.dart';
import '../../create_task/screen/widget/item_task.dart';
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

  @override
  void initState() {
    super.initState();
    listComment = [];
    _onGetListComment();
  }

  void _onGetListComment() {
    context.read<MenuInboxBloc>().add(GetListCommentEvent());
  }

  void _handleListener(BuildContext context, MenuInboxState state) {
    if (state is GetListTaskSuccessState) {
      listComment = state.listTask;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuInboxBloc, MenuInboxState>(
      listener: (context, state) => _handleListener(context, state),
      builder: (context, state) {
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
              child: ItemTask(onClickEdit: showCreateTaskSheet),
            ),
          ),
        );
      },
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
                    context.read<MenuInboxBloc>().add(TitleEvent(value));
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
                    context.read<MenuInboxBloc>().add(DescriptionEvent(value));
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
