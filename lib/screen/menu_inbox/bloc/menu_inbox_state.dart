part of 'menu_inbox_bloc.dart';

class MenuInboxState {
  const MenuInboxState();
}

class MenuInboxInitial extends MenuInboxState {}

class GetListTaskSuccessState extends MenuInboxState {
  List<Task> listTask;
  GetListTaskSuccessState(this.listTask);
}
