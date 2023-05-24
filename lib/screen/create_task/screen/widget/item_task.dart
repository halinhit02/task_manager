import 'package:flutter/material.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'show_dialog.dart';

class ItemTask extends StatefulWidget {
  final Function()? onClickEdit;
  const ItemTask({Key? key, this.onClickEdit}) : super(key: key);

  @override
  State<ItemTask> createState() => _ItemTaskState();
}

class _ItemTaskState extends State<ItemTask> {
  @override
  Widget build(BuildContext context) {
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
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
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
                        'Priority task 1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownButton2(
                      customButton: const Icon(
                        Icons.menu_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                      items: [
                        ...MenuItems.firstItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(
                                item, item.text, context, widget.onClickEdit),
                          ),
                        ),
                      ],
                      dropdownStyleData: DropdownStyleData(
                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.teal,
                        ),
                        elevation: 8,
                        offset: const Offset(0, 8),
                      ),
                      onChanged: (value) {},
                      menuItemStyleData: MenuItemStyleData(
                        customHeights: [
                          ...List<double>.filled(
                              MenuItems.firstItems.length, 48),
                        ],
                        padding: const EdgeInsets.only(left: 16, right: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      decoration: const BoxDecoration(
                          border: Border.fromBorderSide(BorderSide(
                            width: 2,
                            color: Colors.teal,
                          )),
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          )),
                      child: const Icon(
                        Icons.circle_rounded,
                        color: Colors.teal,
                        size: 8,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Masyla Website Project',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Text(
                      '08:00 PM',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Today, Mon 20 Jul 2022',
                        style: TextStyle(color: Colors.black54),
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
  static const List<MenuItem> firstItems = [delete, edit];

  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);

  static Widget buildItem(MenuItem item, String text, BuildContext context,
      Function()? _oncliclEdit) {
    return GestureDetector(
      onTap: () {
        if (item.text == delete.text) {
          showDialog(
              context: context,
              builder: (context) {
                return ShowDialog();
              });
        }
        if (item.text == edit.text) {
          _oncliclEdit!();
        }
      },
      child: Row(
        children: [
          Icon(item.icon, color: Colors.white, size: 22),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
