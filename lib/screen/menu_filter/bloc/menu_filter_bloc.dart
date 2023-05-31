import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/date_time_helper.dart';
import '../../../model/task.dart';
import '../../../repository/database_repos.dart';

part 'menu_filter_event.dart';
part 'menu_filter_state.dart';

class MenuFilterBloc extends Bloc<MenuFilterEvent, MenuFilterState> {
  late List<Task> listTask;
  DateTime date = DateTime.now();
  MenuFilterBloc() : super(MenuFilterInitial()) {
    listTask = [];
    on<GetListTaskEvent>(_getListTask);
    on<UpdateTime>(_updateTime);
  }

  void _updateTime(UpdateTime event, Emitter<MenuFilterState> emit) {
    date = event.date;
  }

  void _getListTask(
      GetListTaskEvent event, Emitter<MenuFilterState> emit) async {
    listTask = await DatabaseRepo.instance
        .getTasksByDate(DateTimeHelper.getDateTime(date));
    emit(GetListTaskSuccessState(listTask));
  }
}
