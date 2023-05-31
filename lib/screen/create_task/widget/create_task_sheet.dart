import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thuc_tap_chuyen_nganh/helper/dialog_helper.dart';

import '../../../../model/task.dart';
import '../../../../repository/database_repos.dart';
import 'date_time_sheet.dart';
import 'package:intl/intl.dart';

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({Key? key, this.currentTask, this.isEdit = false})
      : super(key: key);

  final Task? currentTask;
  final bool isEdit;

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  TextEditingController titleTextEditing = TextEditingController();
  TextEditingController descriptionTextEditing = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Task task = Task(
        id: selectedDateTime.millisecondsSinceEpoch.toString(),
        title: titleTextEditing.text,
        description: descriptionTextEditing.text,
        time: selectedDateTime.millisecondsSinceEpoch);
    if (widget.isEdit) {
      task = widget.currentTask!;
      titleTextEditing.text = task.title;
      descriptionTextEditing.text = task.description;
      selectedDateTime = DateTime.fromMillisecondsSinceEpoch(task.time);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: titleTextEditing,
            decoration: const InputDecoration(
              hintText: 'Task\'s Title',
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            onChanged: (value) {
              task.title = value;
            },
          ),
          TextField(
            autofocus: true,
            controller: descriptionTextEditing,
            decoration: const InputDecoration(
              hintText: 'Task\'s Description',
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            onChanged: (value) {
              task.description = value;
            },
          ),
          MaterialButton(
            onPressed: () {
              _showDateTimeSheet(
                (time) {
                  setState(() {
                    selectedDateTime = time;
                  });
                },
                value: selectedDateTime,
              );
            },
            padding: EdgeInsets.zero,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title:
                  Text(DateFormat('hh:mm dd/MM/yyyy').format(selectedDateTime)),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              if (task.title.isEmpty) {
                Fluttertoast.showToast(msg: 'Input task\'s title.');
                return;
              } else if (task.description.isEmpty) {
                Fluttertoast.showToast(msg: 'Input task\'s description.');
                return;
              }
              DialogHelper.showLoadingDialog(context);
              DatabaseRepo.instance.setTask(task).then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                DialogHelper.showSnackBar(context, 'New task is created.');
              }).catchError((e) {
                Navigator.of(context).pop();
                Fluttertoast.showToast(msg: e.toString());
              });
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
  }

  void _showDateTimeSheet(Function(DateTime) onTimeAdded, {DateTime? value}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => DateTimeSheet(
              value: value,
              onTimeAdded: onTimeAdded,
            ));
  }
}
