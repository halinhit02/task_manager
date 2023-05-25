import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/model/task.dart';
import 'package:thuc_tap_chuyen_nganh/repository/database_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/screen/widget/create_task_sheet.dart';
import 'package:thuc_tap_chuyen_nganh/screen/create_task/screen/widget/item_task.dart';

import '../bloc/menu_homepage_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuHomepageBloc(),
      child: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TimeOfDay time = const TimeOfDay(hour: 07, minute: 00);
  final DatabaseRepo _databaseRepo = DatabaseRepo.instance;
  late List<Task> listTask;

  @override
  void initState() {
    super.initState();
    listTask = [];
    _onGetListTask();
  }

  void _onGetListTask() {
    context.read<MenuHomepageBloc>().add(GetListTaskEvent());
  }

  void _handleListener(BuildContext context, MenuHomepageState state) {
    if (state is TimeState) {
      time = state.time;
    }
    if (state is GetListTaskSuccessState) {
      listTask = state.listTask;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuHomepageBloc, MenuHomepageState>(
      listener: (context, state) => _handleListener(context, state),
      child: BlocBuilder<MenuHomepageBloc, MenuHomepageState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Today',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
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
                      setState(() {
                      });
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
                                            style:
                                                TextStyle(color: Colors.grey),
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
                      child: FutureBuilder<List<Task>>(
                          future: _databaseRepo.getTasksByDate(
                            DateTime.now().millisecondsSinceEpoch,
                          ),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
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
                                onClickEdit: () => showCreateTaskSheet(),
                                index: index,
                              ),
                            );
                          })),
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
        },
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
