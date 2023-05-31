part of 'menu_filter_bloc.dart';

class MenuFilterEvent {
  const MenuFilterEvent();
}

class GetListTaskEvent extends MenuFilterEvent {}

class UpdateTime extends MenuFilterEvent {
  final DateTime date;
  UpdateTime(this.date);
}
