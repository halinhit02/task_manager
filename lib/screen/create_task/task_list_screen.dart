import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/repository/database_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/widget/create_task_sheet.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/widget/item_task.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
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
              onTap: () async {
                await showCreateTaskSheet();
                setState(() {});
              },
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
                                  const Expanded(
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
                            const Divider(
                              thickness: 0.6,
                              height: 2,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Add your task',
                                      style: TextStyle(color: Colors.grey),
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
              child: RefreshIndicator(
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
                          return const Center(
                            child: Text('There are no data.'),
                          );
                        }
                        var taskList = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: taskList.length,
                          itemBuilder: (_, index) => ItemTask(
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
                        );
                      })),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showCreateTaskSheet();
          setState(() {});
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future showCreateTaskSheet() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 2 / 3,
        ),
        builder: (BuildContext context) => const CreateTaskSheet());
  }
}
