import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/task.dart';
import '../../create_task/widget/item_task.dart';
import '../bloc/menu_filter_bloc.dart';

class MyMenuFilter extends StatelessWidget {
  const MyMenuFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuFilterBloc(),
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
  late List<Task> listTask;

  @override
  void initState() {
    super.initState();
    listTask = [];
    _onGetListTask();
  }

  void _onGetListTask() {
    context.read<MenuFilterBloc>().add(GetListTaskEvent());
  }

  void _handleListener(BuildContext context, MenuFilterState state) {
    if (state is GetListTaskSuccessState) {
      listTask = state.listTask;
    }
  }

  @override
  Widget build(BuildContext context) {
    _onGetListTask();
    return BlocConsumer<MenuFilterBloc, MenuFilterState>(
      listener: (context, state) => _handleListener(context, state),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Schedule',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ColoredBox(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Theme.of(context).primaryColor,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      context.read<MenuFilterBloc>().add(UpdateTime(date));
                    },
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: listTask.length,
                    itemBuilder: (_, index) => ItemTask(
                      task: listTask[index],
                      index: index,
                    ), //ItemTask(),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
