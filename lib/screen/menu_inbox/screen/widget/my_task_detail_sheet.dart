import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_chuyen_nganh/helper/date_time_helper.dart';
import 'package:thuc_tap_chuyen_nganh/model/comment.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/repository/database_repos.dart';

import 'dialog_widget.dart';

class MyTaskDetailSheet extends StatefulWidget {
  const MyTaskDetailSheet({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<MyTaskDetailSheet> createState() => _MyTaskDetailSheetState();
}

class _MyTaskDetailSheetState extends State<MyTaskDetailSheet> {
  String comment = '';
  List<Comment> listComment = [];

  @override
  void initState() {
    super.initState();
    _getListComment();
  }

  void _getListComment() async {
    listComment =
        await DatabaseRepo.instance.getListTaskComment(widget.task.id);
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(widget.task.time);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Detail Task',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.task.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer_sharp, color: Colors.red, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat(DateFormat.HOUR24_MINUTE)
                                .format(dateTime),
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*Row(
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: Colors.grey,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.access_alarm_sharp,
                                  color: Colors.grey)),
                          Icon(
                            Icons.flag,
                            color: Colors.grey,
                          ),
                          const Expanded(child: const SizedBox()),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.menu_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                          )
                        ],
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: 'Enter your comment...',
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _showDialogTimeWorkDetail();
                    },
                    icon: const Icon(
                      Icons.link,
                    )),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      setState(() async {
                        await DatabaseRepo.instance.setTaskComment(
                          Comment(
                              id: DateTimeHelper.getCurrentTimeMillis()
                                  .toString(),
                              content: comment,
                              time: DateTime.now().millisecondsSinceEpoch),
                          widget.task.id,
                        );
                        listComment = await DatabaseRepo.instance
                            .getListTaskComment(widget.task.id);
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 20,
                    ))
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(listComment.length, (index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text('${listComment[index].content}'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _showDialogTimeWorkDetail() async {
    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogWidget();
        });
  }
}
