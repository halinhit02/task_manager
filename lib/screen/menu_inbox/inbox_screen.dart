import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/screen/menu_inbox/widget/my_task_detail_sheet.dart';

import '../../model/task.dart';
import '../../repository/database_repos.dart';
import '../create_task/widget/item_task.dart';

class MenuInboxScreen extends StatefulWidget {
  const MenuInboxScreen({Key? key}) : super(key: key);

  @override
  State<MenuInboxScreen> createState() => _MenuInboxScreenState();
}

class _MenuInboxScreenState extends State<MenuInboxScreen> {
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
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<List<Task>>(
            future: DatabaseRepo.instance.getTasksByDate(
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('There are no data.'),
                    MaterialButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.refresh_rounded),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Refresh'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              var taskList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () => _showTaskDetailSheet(taskList[index]),
                  child: ItemTask(
                    task: taskList[index],
                    index: index,
                    onRemoveClick: () {
                      DatabaseRepo.instance
                          .deleteTask(
                        taskList[index],
                      )
                          .then((value) {
                        Fluttertoast.showToast(msg: 'Task is deleted.');
                        setState(() {});
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: e.toString());
                      });
                    },
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
}
