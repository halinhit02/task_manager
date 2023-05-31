import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thuc_tap_chuyen_nganh/helper/dialog_helper.dart';
import 'package:thuc_tap_chuyen_nganh/model/task_type.dart';

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

  TaskType selectedValue = TaskType.Waiting;

  List<DropdownMenuItem<TaskType>> _addDividersAfterItems(
      List<TaskType> items) {
    List<DropdownMenuItem<TaskType>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<TaskType>(
            value: item,
            child: Text(
              item.name,
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<TaskType>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> itemsHeights = [];
    for (var i = 0; i < (TaskType.values.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

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
      selectedValue = task.type;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
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
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                selectedValue.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: _addDividersAfterItems(TaskType.values),
              value: selectedValue,
              onChanged: (value) {
                if (value != null) {
                  selectedValue = value;
                  task.type = value;
                }
                setState(() {
                });
              },
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: MenuItemStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                customHeights: _getCustomItemsHeights(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              onPressed: () {
                _showDateTimeSheet(
                  (time) {
                    setState(() {
                      selectedDateTime = time;
                      task.time = selectedDateTime.millisecondsSinceEpoch;
                    });
                  },
                  value: selectedDateTime,
                );
              },
              padding: EdgeInsets.zero,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                    DateFormat('hh:mm dd/MM/yyyy').format(selectedDateTime)),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
              ),
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
              if (widget.isEdit) {
                DatabaseRepo.instance.updateTask(task).then((value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  DialogHelper.showSnackBar(context, 'The task is updated.');
                }).catchError((e) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: e.toString());
                });
                return;
              }
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
            child: SizedBox(
              width: double.maxFinite,
              child: Center(
                child: Text(
                  widget.isEdit ? 'Update task' : 'Create task',
                  style: const TextStyle(
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
