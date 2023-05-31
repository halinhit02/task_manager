part of 'menu_filter_bloc.dart';

class MenuFilterState {
  const MenuFilterState();
}

class MenuFilterInitial extends MenuFilterState {}

class GetListTaskSuccessState extends MenuFilterState {
  List<Task> listTask;
  GetListTaskSuccessState(this.listTask);
}
