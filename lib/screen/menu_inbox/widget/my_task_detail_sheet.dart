import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_chuyen_nganh/helper/date_time_helper.dart';
import 'package:thuc_tap_chuyen_nganh/helper/dialog_helper.dart';
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
  List<Comment> listComment = [];
  TextEditingController commentTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void removeComment(String id) {
    DialogHelper.showAlertDialog(context, 'Do you want remove this comment?',
        () {
      DatabaseRepo.instance
          .deleteTaskComment(
        id,
        widget.task.id,
      )
          .then((value) {
        Fluttertoast.showToast(msg: 'Comment is deleted.');
        setState(() {});
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(widget.task.time);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(children: [
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
                        const Icon(Icons.timer_sharp,
                            color: Colors.red, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat(DateFormat.HOUR24_MINUTE).format(dateTime),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          DateFormat(DateFormat.YEAR_NUM_MONTH_WEEKDAY_DAY)
                              .format(dateTime),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
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
            focusNode: focusNode,
            controller: commentTextController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintText: 'Enter your comment...',
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            onSubmitted: (value) {},
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
                  onPressed: () async {
                    if (commentTextController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter the comment.');
                    }
                    DatabaseRepo.instance
                        .setTaskComment(
                      Comment(
                        id: DateTimeHelper.getCurrentTimeMillis().toString(),
                        content: commentTextController.text,
                        time: DateTime.now().millisecondsSinceEpoch,
                      ),
                      widget.task.id,
                    )
                        .then((value) {
                      commentTextController.text = '';
                      focusNode.unfocus();
                      Fluttertoast.showToast(msg: 'The comment is added.');
                      setState(() {});
                    }).catchError(
                      (e) => Fluttertoast.showToast(msg: e.toString()),
                    );
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 20,
                  ))
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: FutureBuilder<List<Comment>>(
                future:
                    DatabaseRepo.instance.getListTaskComment(widget.task.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  }
                  var commentList = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: commentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var dateTime = DateTime.fromMillisecondsSinceEpoch(
                          commentList[index].time);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    commentList[index].content,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat(
                                      DateFormat.HOUR24_MINUTE,
                                    ).format(dateTime),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                removeComment(commentList[index].id);
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ]),
      ),
    );
  }

  void _showDialogTimeWorkDetail() async {
    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const DialogWidget();
        });
  }
}
