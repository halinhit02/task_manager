import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/date_time_helper.dart';
import '../../../model/task.dart';
import '../../../repository/database_repos.dart';

part 'menu_homepage_event.dart';
part 'menu_homepage_state.dart';

class MenuHomepageBloc extends Bloc<MenuHomepageEvent, MenuHomepageState> {
  Task? task;
  // late String title;
  // late String description;
  List<Task> listTask = [];
  DateTime day = DateTime.now();
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  MenuHomepageBloc() : super(MenuHomepageInitial()) {
    // title = '';
    // description = '';
    on<TitleEvent>(_onUpdateTitle);
    on<DescriptionEvent>(_onUpdateDescription);
    on<DateEvent>(_onUpdateDay);
    on<TimeEvent>(_onUpdateTime);
    on<CreateTaskEvent>(_onCreateTask);
    on<GetListTaskEvent>(_getListTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onUpdateTitle(TitleEvent event, Emitter<MenuHomepageState> emit) {
    task?.title = event.title;
  }

  void _onUpdateDescription(
      DescriptionEvent event, Emitter<MenuHomepageState> emit) {
    task?.description = event.description;
  }

  void _onUpdateDay(DateEvent event, Emitter<MenuHomepageState> emit) {
    task?.id = event.day as String;
  }

  void _onUpdateTime(TimeEvent event, Emitter<MenuHomepageState> emit) {
    task?.time = DateTimeHelper.getCurrentTimeMillis();
  }

  void _onCreateTask(
      CreateTaskEvent event, Emitter<MenuHomepageState> emit) async {
    await DatabaseRepo.instance.setTask(task!);
  }

  void _getListTask(
      GetListTaskEvent event, Emitter<MenuHomepageState> emit) async {
    listTask = await DatabaseRepo.instance
        .getTasksByDate(DateTimeHelper.getCurrentTimeMillis());
    print('check ${listTask.length}');
  }

  void _onDeleteTask(
      DeleteTaskEvent event, Emitter<MenuHomepageState> emit) async {
    await DatabaseRepo.instance.deleteTask(event.task);
    emit(DeleteTaskSuccessState());
  }
}
