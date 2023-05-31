import 'package:flutter/material.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/model/task_type.dart';

import '../../../../helper/dialog_helper.dart';
import 'create_task_sheet.dart';

class ItemTask extends StatelessWidget {
  final Function() onRemoveClick;
  final Task task;
  final int index;

  const ItemTask(
      {Key? key,
      required this.task,
      required this.index,
      required this.onRemoveClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(task.time);

    var taskColor = task.type == TaskType.Waiting
        ? Theme.of(context).primaryColor
        : task.type == TaskType.Running
            ? Colors.orange
            : task.type == TaskType.Canceled
                ? Colors.red
                : Colors.green;
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: taskColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Priority task ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownButton2(
                      customButton: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.menu_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      items: [
                        ...MenuItems.firstItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item, item.text, context,
                                () => showEditTaskSheet(task), onRemoveClick),
                          ),
                        ),
                      ],
                      dropdownStyleData: DropdownStyleData(
                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        elevation: 0,
                        offset: const Offset(0, 8),
                      ),
                      onChanged: (value) {},
                      menuItemStyleData: MenuItemStyleData(
                        customHeights: [
                          ...List<double>.filled(
                              MenuItems.firstItems.length, 48),
                        ],
                        padding: const EdgeInsets.only(left: 15, right: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(BorderSide(
                            width: 2,
                            color: taskColor,
                          )),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(35),
                          )),
                      child: Icon(
                        Icons.circle_rounded,
                        color: taskColor,
                        size: 8,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            task.description,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.6,
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.alarm_rounded,
                    size: 18,
                    color: taskColor,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Text(
                      DateFormat(DateFormat.HOUR24_MINUTE).format(dateTime),
                      style: TextStyle(
                        color: taskColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateFormat(DateFormat.YEAR_NUM_MONTH_WEEKDAY_DAY)
                            .format(dateTime),
                        style: const TextStyle(color: Colors.black54),
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
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share];

  static const home = MenuItem(text: 'Delete', icon: Icons.delete);
  static const share = MenuItem(text: 'Edit', icon: Icons.edit);

  static Widget buildItem(MenuItem item, String text, BuildContext context,
      Function() onEditClick, Function() onDeleteClick) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (item.text == home.text) {
          DialogHelper.showAlertDialog(context,
              'Do you want to remove this task?', () => onDeleteClick());
        }
        if (item.text == share.text) {
          onEditClick();
        }
      },
      child: Row(
        children: [
          Icon(item.icon, size: 22),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.text,
          ),
        ],
      ),
    );
  }
}
