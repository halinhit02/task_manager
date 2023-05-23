part of 'menu_homepage_bloc.dart';

class MenuHomepageState {
  const MenuHomepageState();
}

class MenuHomepageInitial extends MenuHomepageState {}

class DateState extends MenuHomepageState {
  DateTime day;
  DateState(this.day);
}

class TimeState extends MenuHomepageState {
  TimeOfDay time;
  TimeState(this.time);
}

class GetListTaskSuccessState extends MenuHomepageState {
  List<Task> listTask;
  GetListTaskSuccessState(this.listTask);
}

class DeleteTaskSuccessState extends MenuHomepageState {
  // List<Task> listTask;
  // DeleteTaskSuccessState(this.listTask);
}
