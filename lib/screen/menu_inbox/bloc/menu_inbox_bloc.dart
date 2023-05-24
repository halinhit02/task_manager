import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/date_time_helper.dart';
import '../../../model/task.dart';
import '../../../repository/database_repos.dart';

part 'menu_inbox_event.dart';
part 'menu_inbox_state.dart';

class MenuInboxBloc extends Bloc<MenuInboxEvent, MenuInboxState> {
  List<Task> listTask = [];
  Task? task;
  late String comment;
  MenuInboxBloc() : super(MenuInboxInitial()) {
    comment = '';
    on<GetListCommentEvent>(_onGetListCommentEvent);
    on<TitleEvent>(_onUpdateTitle);
    on<DescriptionEvent>(_onUpdateDescription);
    on<DateEvent>(_onUpdateDay);
    on<TimeEvent>(_onUpdateTime);
  }

  void _onGetListCommentEvent(
      GetListCommentEvent event, Emitter<MenuInboxState> emit) async {
    listTask = await DatabaseRepo()
        .getTasksByDate(DateTimeHelper.getCurrentTimeMillis());
    emit(GetListTaskSuccessState(listTask));
  }

  void _onUpdateTitle(TitleEvent event, Emitter<MenuInboxState> emit) {
    task?.title = event.title;
  }

  void _onUpdateDescription(
      DescriptionEvent event, Emitter<MenuInboxState> emit) {
    task?.description = event.description;
  }

  void _onUpdateDay(DateEvent event, Emitter<MenuInboxState> emit) {
    task?.id = event.day as String;
  }

  void _onUpdateTime(TimeEvent event, Emitter<MenuInboxState> emit) {
    task?.time = DateTimeHelper.getCurrentTimeMillis();
  }
}
